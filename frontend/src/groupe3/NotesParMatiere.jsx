import React, { useState, useEffect } from 'react';
import { API_BASE_URL } from '../config';

const NotesParMatiere = () => {
    const [user, setUser] = useState(null);
    const [matieres, setMatieres] = useState([]);
    const [selectedMatiere, setSelectedMatiere] = useState('');
    const [teacherData, setTeacherData] = useState([]);
    const [selectedClasseIdx, setSelectedClasseIdx] = useState(0);
    const [notes, setNotes] = useState([]);
    const [error, setError] = useState(null);
    const [loading, setLoading] = useState(false);

    useEffect(() => {
        const storedUser = localStorage.getItem('user');
        if (storedUser) {
            const parsedUser = JSON.parse(storedUser);
            setUser(parsedUser);

            if (parsedUser.role === 'ENSEIGNANT') {
                setLoading(true);
                fetch(`${API_BASE_URL}/get_teacher_overview.php?user_id=${parsedUser.id}`)
                    .then(res => res.json())
                    .then(data => {
                        console.log("Teacher Overview Data:", data);
                        if (data && data.error) {
                            setError(data.error);
                            setTeacherData([]);
                        } else if (data) {
                            setTeacherData(Array.isArray(data) ? data : []);
                            if (Array.isArray(data) && data.length > 0) {
                                setSelectedMatiere(data[0].matiere);
                            }
                        }
                        setLoading(false);
                    })
                    .catch(err => {
                        console.error(err);
                        setError("Erreur réseau: " + err.message);
                        setLoading(false);
                    });
            } else {
                fetch(`${API_BASE_URL}/get_matieres.php`)
                    .then(res => res.json())
                    .then(setMatieres)
                    .catch(err => console.error("Erreur chargement matières:", err));
            }
        }
    }, []);

    // Pour l'admin/responsable : charger les notes par matière
    useEffect(() => {
        if (user?.role !== 'ENSEIGNANT' && selectedMatiere) {
            fetch(`${API_BASE_URL}/get_notes_matiere.php?matiere_id=${selectedMatiere}`)
                .then(res => res.json())
                .then(setNotes)
                .catch(err => console.error("Erreur chargement notes:", err));
        }
    }, [selectedMatiere, user]);

    const isTeacher = user?.role === 'ENSEIGNANT';
    const filteredTeacherData = isTeacher ? teacherData.filter(d =>
        (d.matiere || '').trim().toLowerCase() === (selectedMatiere || (teacherData.length > 0 ? teacherData[0].matiere : '')).trim().toLowerCase()
    ) : [];
    const currentClasse = isTeacher && filteredTeacherData.length > 0 ? filteredTeacherData[selectedClasseIdx] : null;

    useEffect(() => {
        if (isTeacher && teacherData.length > 0 && !selectedMatiere) {
            setSelectedMatiere(teacherData[0].matiere);
        }
    }, [teacherData, isTeacher, selectedMatiere]);

    return (
        <div className="slide-up">
            <header style={{ marginBottom: '40px' }}>
                <h1 className="text-gradient" style={{ fontSize: '2.5rem', marginBottom: '8px' }}>
                    {isTeacher ? "Aperçu de mes Classes" : "Analyse par Matière"}
                </h1>
                <p style={{ color: 'var(--text-dim)', fontSize: '1.1rem' }}>
                    {isTeacher
                        ? `Consultez les résultats de vos élèves en ${currentClasse?.matiere || 'votre matière'}.`
                        : "Visualisez les performances par discipline."}
                </p>
            </header>

            {error && (
                <div style={{
                    padding: '15px 20px',
                    backgroundColor: 'rgba(239, 68, 68, 0.1)',
                    border: '1px solid #ef4444',
                    borderRadius: '12px',
                    color: '#b91c1c',
                    marginBottom: '20px',
                    fontSize: '0.9rem',
                    fontWeight: '600'
                }}>
                    ⚠️ {error}
                </div>
            )}

            <div className="glass-card" style={{ padding: '30px' }}>
                {isTeacher ? (
                    <>
                        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '20px', marginBottom: '32px' }}>
                            <div>
                                <label style={labelStyle}>Matière :</label>
                                <select
                                    value={selectedMatiere}
                                    onChange={(e) => {
                                        setSelectedMatiere(e.target.value);
                                        setSelectedClasseIdx(0); // Reset classe quand la matière change
                                    }}
                                    style={inputStyle}
                                >
                                    {[...new Set(teacherData.map(d => d.matiere))].map((m, i) => (
                                        <option key={i} value={m}>{m}</option>
                                    ))}
                                </select>
                            </div>

                            <div>
                                <label style={labelStyle}>Classe :</label>
                                <select
                                    value={selectedClasseIdx}
                                    onChange={(e) => setSelectedClasseIdx(parseInt(e.target.value))}
                                    style={inputStyle}
                                >
                                    {filteredTeacherData
                                        .map((c, idx) => (
                                            <option key={idx} value={idx}>{c.classe_nom}</option>
                                        ))
                                    }
                                </select>
                            </div>
                        </div>

                        {currentClasse && currentClasse.eleves && currentClasse.eleves.length > 0 ? (
                            <div className="table-responsive">
                                <table style={styles.table}>
                                    <thead>
                                        <tr style={styles.headerRow}>
                                            <th style={styles.th}>ÉLÈVE</th>
                                            <th style={styles.th}>D1</th>
                                            <th style={styles.th}>D2</th>
                                            <th style={styles.th}>D3</th>
                                            <th style={styles.th}>I1</th>
                                            <th style={styles.th}>I2</th>
                                            <th style={styles.th}>I3</th>
                                            <th style={styles.th}>E1</th>
                                            <th style={{ ...styles.th, backgroundColor: 'rgba(249, 177, 122, 0.1)', color: 'var(--primary)' }}>MOYENNE</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {currentClasse.eleves.map((e, i) => (
                                            <tr key={i} style={styles.row}>
                                                <td style={{ ...styles.td, fontWeight: '700', textAlign: 'left' }}>{e.eleve}</td>
                                                <td style={styles.td}>{e.notes.D1 ?? '-'}</td>
                                                <td style={styles.td}>{e.notes.D2 ?? '-'}</td>
                                                <td style={styles.td}>{e.notes.D3 ?? '-'}</td>
                                                <td style={styles.td}>{e.notes.I1 ?? '-'}</td>
                                                <td style={styles.td}>{e.notes.I2 ?? '-'}</td>
                                                <td style={styles.td}>{e.notes.I3 ?? '-'}</td>
                                                <td style={styles.td}>{e.notes.E1 ?? '-'}</td>
                                                <td style={{ ...styles.td, fontWeight: '900', color: 'var(--primary)', backgroundColor: 'rgba(249, 177, 122, 0.05)' }}>
                                                    {e.moyenne}
                                                </td>
                                            </tr>
                                        ))}
                                    </tbody>
                                </table>
                            </div>
                        ) : (
                            <div style={{ textAlign: 'center', padding: '60px', color: 'var(--text-dim)' }}>
                                {loading ? (
                                    <div className="flex flex-col items-center gap-3">
                                        <div className="animate-spin h-8 w-8 border-4 border-primary border-t-transparent rounded-full"></div>
                                        <span>Chargement des données...</span>
                                    </div>
                                ) : (
                                    teacherData.length === 0 ? "Aucune donnée disponible (vérifiez que l'enseignant est bien affecté à des classes)." : "Aucun élève ou note validée pour cette sélection."
                                )}
                            </div>
                        )}
                    </>
                ) : (
                    <>
                        <div style={{ marginBottom: '24px' }}>
                            <label style={{ display: 'block', marginBottom: '8px', fontWeight: '800', color: 'var(--secondary)' }}>
                                Discipline :
                            </label>
                            <select
                                onChange={(e) => setSelectedMatiere(e.target.value)}
                                value={selectedMatiere}
                                style={inputStyle}
                            >
                                <option value="">-- Choisir une matière --</option>
                                {matieres.map(m => <option key={m.id} value={m.id}>{m.nom}</option>)}
                            </select>
                        </div>

                        <table style={styles.table}>
                            <thead>
                                <tr style={styles.headerRow}>
                                    <th style={styles.th}>Élève</th>
                                    <th style={{ ...styles.th, textAlign: 'center' }}>Note</th>
                                    <th style={{ ...styles.th, textAlign: 'right' }}>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                {notes.length > 0 ? notes.map((n, index) => (
                                    <tr key={index} style={styles.row}>
                                        <td style={styles.td}>{n.nom} {n.prenom}</td>
                                        <td style={{ ...styles.td, textAlign: 'center', fontWeight: '800', color: 'var(--secondary)' }}>
                                            {n.note} / 20
                                        </td>
                                        <td style={{ ...styles.td, textAlign: 'right', color: 'var(--text-dim)' }}>
                                            {n.date_saisie ? new Date(n.date_saisie).toLocaleDateString() : 'N/A'}
                                        </td>
                                    </tr>
                                )) : (
                                    <tr>
                                        <td colSpan="3" style={{ textAlign: 'center', padding: '40px', color: 'var(--text-dim)' }}>
                                            Sélectionnez une matière pour voir les résultats.
                                        </td>
                                    </tr>
                                )}
                            </tbody>
                        </table>
                    </>
                )}
            </div>
        </div>
    );
};

const labelStyle = {
    display: 'block',
    marginBottom: '8px',
    fontWeight: '800',
    color: 'var(--secondary)',
    fontSize: '0.75rem',
    textTransform: 'uppercase',
    letterSpacing: '1px'
};

const inputStyle = {
    width: '100%',
    padding: '12px 16px',
    borderRadius: '10px',
    border: '1px solid #e2e8f0',
    backgroundColor: '#fff',
    outline: 'none',
    fontSize: '0.9rem',
    fontWeight: '600',
    transition: 'border-color 0.2s',
};

const styles = {
    table: { width: '100%', borderCollapse: 'separate', borderSpacing: '0' },
    headerRow: { borderBottom: '2px solid #f1f5f9', textAlign: 'left' },
    th: {
        padding: '16px',
        fontSize: '0.7rem',
        color: 'var(--text-dim)',
        textTransform: 'uppercase',
        fontWeight: '800',
        borderBottom: '2px solid #f1f5f9'
    },
    td: {
        padding: '16px',
        borderBottom: '1px solid #f1f5f9',
        fontSize: '0.9rem',
        textAlign: 'center'
    },
    row: { transition: 'background 0.2s' }
};

export default NotesParMatiere;
