import { Component } from '@angular/core';
import { FormBuilder, FormArray } from '@angular/forms';
import { ApiService } from '../services/api.service';

@Component({
  selector: 'app-cv-form',
  templateUrl: './cv-form.component.html'
})
export class CvFormComponent {
  constructor(private fb: FormBuilder, private api: ApiService) {}

  uye_id = 1; // Örnek olarak sabit
  cvForm = this.fb.group({
    fotograf: [''],
    telefon: [''],
    cinsiyet: [''],
    dogum_yeri: [''],
    medeni_durum: [''],
    ehliyet: [''],
    ikametgah_adresi: [''],
    il: [''],
    ilce: [''],
    egitimler: this.fb.array([]),
    diller: this.fb.array([]),
    deneyimler: this.fb.array([]),
    alanlar: this.fb.array([]),
  });

  onSubmitCV() {
    const cvData = {
      uye_id: this.uye_id,
      cv: this.cvForm.value
    };

    this.api.saveCV(cvData).subscribe(res => {
      if (res['success']) {
        alert('CV başarıyla kaydedildi!');
      } else {
        alert('Hata: ' + res['message']);
      }
    });
  }
}
