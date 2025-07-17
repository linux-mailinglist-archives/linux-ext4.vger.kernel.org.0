Return-Path: <linux-ext4+bounces-9053-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F2EB09283
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 19:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509595A1D28
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 17:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AE22FCFF5;
	Thu, 17 Jul 2025 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpyk+pPf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169A82FCFFE;
	Thu, 17 Jul 2025 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771566; cv=none; b=UvaMYxXzckGy8K1OVEwDSqbQQBxbMO0uXsrNn6x9iO1inEiKtnWwh2M/P9P4EcKdYh27LP0AX3n1cox4SWU6LcwCu8eI9qQzG5FYtZU62X4L7d/OxYLeegPNXd3+Lv57I1Lmf2W/AxMvPB2XviWPsTd1nG096wQmy/oHa8cls8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771566; c=relaxed/simple;
	bh=If1xPwlarJra+6OM7a2NpAh+OP713cfx9A4bU8aU6Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQucWfdNbsaejXxV7TlQTWZxbQoGWk9QaHkT70Yi6bQjAnABTArZPDW99HylMBlVpNL7Il9dILzbJqwnkU8qpnR4ZBSlfTPrkjlxcANHKP+HZJ/p4POcLZKl0jkix4F+3sITW/PdkMuM9q+xCv4kms49ZZiKS09ficExKn+9mPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpyk+pPf; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8bcfaaaacaso1156710276.1;
        Thu, 17 Jul 2025 09:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752771564; x=1753376364; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u/zwFbYAKcArN372lmLzuTd5flHgKC3aB7a6CtpyhgY=;
        b=fpyk+pPfAipGwudUEnXdj8XgXF0+d67VNhqdQzl8uHuc4IhGLPP1aOfkTRKo8m5I/M
         IgzajZ+DrESmZINkV6iBsBVxjpxT3uybjHK2TO6ksQ7lSvBrZtCRtlUlE9fHn+pvfpt6
         cU+gw4Gh113c9J9g7fASPLpQrnJR1u0EbH5H1XQhOqEQmYJ5R3tH281Y8s+oZQ9oG2I5
         GhbcIvcpogpp/CjhRLjBclvPmgdBQw0tuN4vwYJ0djeSbqeI3/sn89PGYY6cKbNbQgWE
         AnypU2aPJEZugnw550r4Q4Kf1YB+1bstc+BX7wjZcOVnsuzvtos+QF58IW7i+EKWBHKr
         OyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752771564; x=1753376364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/zwFbYAKcArN372lmLzuTd5flHgKC3aB7a6CtpyhgY=;
        b=By6CSk2DF3IVWdrkkA96714V58dGU2h/gS6CoOI5H/cPCcIB3bmgH/7edtJY47FQf8
         Cx+SNBc53IY5dgMEgrjbXwTxgpdIeLNI7wmUH48hI+NrTPFvf9y7xU0xVNLYyKbpODGM
         QFEi2BWuZoQ97TEgtZ3Fi1V32sqlvCQLoTu9P0hhd37kLNj2NDSAeZ/rlhtJeFwsv+8n
         /92+/BebR3A+A7qZkctXS6SkrRnaB084DzULcCLL7dIBsLdxegEAfG1W3a21B7K7A6Mz
         Owd9O/gTyTYNgIP9DpAkJnxOetLqSWB8egTgBFA2VkXcoc0nBp2HGXV5DiPnpfwXP5lY
         vasw==
X-Forwarded-Encrypted: i=1; AJvYcCVxdxW18Wz9rACsGn+POhhY8+Es6TQD16KbWShMkDswvM+r/vMKb63xwlr0wicx6E2OTalg3ZNaiM2YjL9m@vger.kernel.org, AJvYcCXozHLdOlA/eKLT0qCvhBvdvnCbt4WQwTjKc/11WtE9jqJqfOwPAdr+FqWDrG4wifna5ymKEq9evySk@vger.kernel.org
X-Gm-Message-State: AOJu0Ywadt24A2F+1LO1HhnO8pUVN2c5P1JaGCvK7qF/tD+V0vancWui
	rIS6/xuAKadc1ibayd8jCdW3KRw6ZwkgwrqJVlccxgiJUIxp+2fJ0K/JmzQ8fm+HYDukqSvIElh
	uNEfIbtVBYRUxR7Ws5sPZHRKD/+ry16M=
X-Gm-Gg: ASbGncse8c178NTCobnj+ozVMo1xc7K2eAvr2J43UfUZTq38i2kiF6oL1C+fUbuBszL
	QF5OBDzhTu5fsRxSJQh03BIbp95VaWH4gl+6Y3W4kqC4AlCcNItKNxJpj9h8+LjV9UINY6UJrWP
	ulU5Ou034nK7lT4DmkeMAlOmco4ZBNdSQHXhNKfNTaJMgYcl5ADSHHyvHKqDcj8j1hGKHF0MC0U
	p7kprtZuvfv1EsRNIiVeMlQQ0tdtOHUNiokumuyArE2zIReQyk=
X-Google-Smtp-Source: AGHT+IGOLRT7dSbLqr1m4qPtVmh++Ue6u0sY/ivKvKuVaXedWB1iHHAt5QU0mf6SGdBtoWyjpsCDhwubHItgX3V3b5A=
X-Received: by 2002:a05:6902:1147:b0:e8d:718f:cffa with SMTP id
 3f1490d57ef6-e8d718fd4d2mr2645469276.6.1752771563936; Thu, 17 Jul 2025
 09:59:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF3JpA7a0ExYEJ8_c7v7evKsV83s+_p7qUoH9uiYZLPxT_Md6g@mail.gmail.com>
 <20250717145911.GB112967@mit.edu>
In-Reply-To: <20250717145911.GB112967@mit.edu>
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Date: Thu, 17 Jul 2025 09:59:13 -0700
X-Gm-Features: Ac12FXzKQgdJ4Meqkxbx9lkBFJwxLXj6l8EsX4wACgQvgjYGOQxzCEQPsuvRwr0
Message-ID: <CAF3JpA6RwyzQMdG4y3P_8jkaS8qUFPerE5MJ8Xecs+VkbPEmpg@mail.gmail.com>
Subject: Re: [PATCH] ext4: do not BUG when INLINE_DATA_FL lacks system.data xattr
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: syzbot+544248a761451c0df72f@syzkaller.appspotmail.com, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

>
> Thanks ofor the patch!  However, instead of doing an xattr lookup in
> ext4_prepare_inline_data(), we can more simply and more efficiently
> just not BUG in ext4_update_inline_data, like this:

Thanks for the response and for taking the time to address the issue.

Just to clarify the intent behind the earlier patch [1]: it was meant to
catch the missing system.data xattr early in ext4_prepare_inline_data(),
before branching into paths that assume the xattr is present.

> @@ -354,6 +354,12 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
>         if (error)
>                 goto out;
>
> +       if (is.s.not_found) {
> +               EXT4_ERROR_INODE(inode, "missing inline data xattr");
> +               error = -EFSCORRUPTED;
> +               goto out;
> +       }
> +
>         BUG_ON(is.s.not_found);

The current patch addresses ext4_update_inline_data() directly, but the
same condition also leads to a BUG_ON in ext4_create_inline_data() [2],
which the earlier approach intended to prevent as well.

Later, a third instance was found in ext4_inline_data_truncate() [3],
which also contains a similar BUG_ON and might need the same kind of
check.

Reducing duplicated checks across these sites would be beneficial, though
fixing each case directly also looks reasonable and straightforward.

[1] https://lore.kernel.org/all/20250710175837.29822-2-moonhee.lee.ca@gmail.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/inline.c?h=v6.16-rc6#n306
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/inline.c?h=v6.16-rc6#n1906

