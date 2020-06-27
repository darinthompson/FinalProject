import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { RegisterComponent } from './components/register/register.component';
import { HomeComponent } from './components/home/home.component';
import { UserComponent } from './components/user/user.component';
import { NavBarComponent } from './components/nav-bar/nav-bar.component';
import { ProfileComponent } from './components/profile/profile.component';
import { SeriesComponent } from './components/series/series.component';
import { SeriesMatchComponent } from './components/series-match/series-match.component';
import { GameComponent } from './components/game/game.component';
import { ArticleComponent } from './components/article/article.component';
import { CommentComponent } from './components/comment/comment.component';


@NgModule({
  declarations: [
    AppComponent,
    RegisterComponent,
    HomeComponent,
    UserComponent,
    NavBarComponent,
    ProfileComponent,
    SeriesComponent,
    SeriesMatchComponent,
    GameComponent,
    ArticleComponent,
    CommentComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
