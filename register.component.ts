import { Component } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ApiService } from './api.service';


@Component({
  selector: 'app-register',
  templateUrl: './register.component.html'
})
export class RegisterComponent {
  constructor(private fb: FormBuilder, private api: ApiService) {}

  registerForm = this.fb.group({
    ad: ['', Validators.required],
    soyad: ['', Validators.required],
    sifre: ['', Validators.required],
    eposta: ['', Validators.required],
    tc_kimlik_no: ['', Validators.required],
    dogum_tarihi: ['', Validators.required],
  });

  onSubmit() {
    this.api.register(this.registerForm.value).subscribe(res => {
      if (res['success']) {
        alert('Kayıt başarılı!');
      } else {
        alert('Kayıt hatası: ' + res['message']);
      }
    });
  }
}
