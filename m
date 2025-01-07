Return-Path: <linux-ext4+bounces-5916-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F378A03598
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 03:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65763A288F
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 02:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4321607B7;
	Tue,  7 Jan 2025 02:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A73KpEFe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348D213C8E8;
	Tue,  7 Jan 2025 02:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218650; cv=none; b=ihELvkqnEBO1WTRiwtYJhJDpbFmMbMxbbif3DezX7LeVINzZpGCqKlUZ5Osrl88RO2ZGkzGkLt2uty8NEnuFGzJ4fQRfjygXUA7Bk+w4K2+ZWMPlg/aPGBZ17YyzEca65AZALWTMY7wFH3fNDh31zWN/MjGuJBfmeBchSJoBoqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218650; c=relaxed/simple;
	bh=ey2xJUbegzP5XFOgI2ebj32HSd/MvVcsda/TiT3Io14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqLvTXKDtJ33OxGLH0oZuHyhT6/O8vQoCBixJvaN0JBs2PFwiwIY0gSvUiYYXI5pIZH3hJJ4bIPNzyeS9ICG5mwCkJH/Wleqa3HyQE5vBctFoDQxc0okNZwrem6km8WM1Y0sL0H77/YAu9P79rTeVuhiJu2zi6AjXMhk0czMPdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A73KpEFe; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5401c68b89eso18235720e87.0;
        Mon, 06 Jan 2025 18:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736218637; x=1736823437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cU2txk/xzWx1vnDy1ZK/Q6VrEQD5zSHT/3VeaSRbyI=;
        b=A73KpEFeQ+iDf6xvUr8zODRgTywDUFpt+5l5gdy1K7hOWwMyEELvyp3jOQdzt0sOuY
         j9UqVgrJGXj47vSKuYYKRKnA4nZP2lQp3so6w2BUfAWe77nPJJaqer1AG0nZfcdF15Nb
         pWMoP36pvEab/Roh5+SS9ITVWr9gnvg5FxGd1DqhNSBhyamNl1ninI8xBjGOXj5efeth
         HT5H3+o/TkFogTY8gXLF2k7QGHUfxaHSeZwqvZRtT8Q7R374DnwgSGy3l0/UnmmlV6QZ
         z8I2ridpYvMgkDqn+WJLIQwXsCg1NsoGnsDtCspTbGLYD2smuO7X8IkRD14gOLWjcuYN
         IjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736218637; x=1736823437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cU2txk/xzWx1vnDy1ZK/Q6VrEQD5zSHT/3VeaSRbyI=;
        b=l2pdBq0LJ2LbNzyRtn5slqTTN8hX1KDIZBgSYpESIMhHl9X86P6A8esU2Cpk13aYkL
         v6v2OkGQ7T2DmndBSvdG/QtcRCAWROso6lipLG1DRkYhkYdEyF3IKR/pR3u1SUoKIHfU
         5vvfzmJmHZfNbULl9cC0qBzmj48VHnZxbI7PPQ+O6iqMCcbSoJG2ponXa7neZZPWgw+J
         NlWz1zOOshRZp8Ze8WSiwbbXsvAOA1SPR6/WkGNTeTb4H8EzQ0xiKsXZMJXkVghuI4au
         YE1fSwIpfgms/4qWXZoX3IawEA4H51ebRx+36ZYYGboOBH3ARp87icUyU0IitnVNahVR
         IC4g==
X-Forwarded-Encrypted: i=1; AJvYcCVMmvSaMxA1Xpc5VTbMw566ho0ScV9A0a06cJey0bpaAOYLgpYI62voH3VjdozZMfz4AA0KUZcu0hv7XXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh1hoG0jRTr4E3JGNU9ImpKqaGECVvcjC6G6iqFwEZFS745uQp
	pjs42g/TQiguV15PzCAt5324hxfSI6YnlXknVTF0EallBl5C3W34cPa+vcPO+2kU684aoLbx5Qv
	tP7fdXznaC8VQN31MUHxNSBmYAXw=
X-Gm-Gg: ASbGncviKmBO1TP7lzvWKq9YPmzfvRrULH9WHdSD77tB+qiK2GjZaUesXRHS3520nMJ
	RJHtYYFkN6cIzUsXrpqCODxzhEle6rJT1BzIFHpo=
X-Google-Smtp-Source: AGHT+IEFBEz+c7TDXCp24ALG6uaQNmeGJsM/X0cvKlFaCXaoZgAiLvz/NFlCk3iiIAWV2nB36xWlDZApyBc6lFxcPDo=
X-Received: by 2002:a05:6512:e92:b0:540:2abf:7016 with SMTP id
 2adb3069b0e04-5427e981c89mr353881e87.17.1736218636902; Mon, 06 Jan 2025
 18:57:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220151625.19769-1-sunjunchao2870@gmail.com>
 <20241220151625.19769-5-sunjunchao2870@gmail.com> <b7nmpjvncdcywd6d3xxoobo3nvoj53gpm5jrjjummuega55qsf@lso74twq6fyz>
In-Reply-To: <b7nmpjvncdcywd6d3xxoobo3nvoj53gpm5jrjjummuega55qsf@lso74twq6fyz>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Tue, 7 Jan 2025 10:57:05 +0800
X-Gm-Features: AbW1kvZJLUG1w-lG8tBSAlgfz84a1X2MJB837uquUo17JM2_Ntx_j0t9fzIOnAk
Message-ID: <CAHB1NahrqxSXXCy-BMpTk8+3ZwrAZgWs1Ev5AtcQe3L2Mf+bSg@mail.gmail.com>
Subject: Re: [PATCH 4/7] ext4: Introduce a new helper function ext4_generic_write_inline_data()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, boyu.mt@taobao.com, tm@tao.ma
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan Kara <jack@suse.cz> =E4=BA=8E2025=E5=B9=B41=E6=9C=886=E6=97=A5=E5=91=A8=
=E4=B8=80 23:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri 20-12-24 23:16:22, Julian Sun wrote:
> > A new function, ext4_generic_write_inline_data(), is introduced
> > to provide a generic implementation of the common logic found in
> > ext4_da_write_inline_data_begin() and ext4_try_to_write_inline_data().
> >
> > This function will be utilized in the subsequent two patches.
> >
> > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
>
> Looks good, just one style nit below. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> ...
> > +     *foliop =3D folio;
> > +     up_read(&EXT4_I(inode)->xattr_sem);
> > +     brelse(iloc.bh);
> > +     return 1;
>
> Here I'd suggest empty line for better readability.

I will fix it in the next version. thanks!
>
> > +out_release_folio:
> > +     up_read(&EXT4_I(inode)->xattr_sem);
> > +     folio_unlock(folio);
> > +     folio_put(folio);
> > +out_stop_journal:
> > +     ext4_journal_stop(handle);
> > +out_release_bh:
> > +     brelse(iloc.bh);
> > +     return ret;
> > +}
> > +
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR



--=20
Julian Sun <sunjunchao2870@gmail.com>

