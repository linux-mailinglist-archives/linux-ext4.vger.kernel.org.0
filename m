Return-Path: <linux-ext4+bounces-9054-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 277D6B0953B
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 21:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA854A3765
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 19:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060F521C179;
	Thu, 17 Jul 2025 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIEutlp7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C391799F;
	Thu, 17 Jul 2025 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752782043; cv=none; b=WK38rEuzb1JwpWdxpSjs8bDTn6ZvSOP72T32jhD3NeOwM2800pfbTCyRQrlx+dUxd39jrdZYAaL7UEtAvA7LBJS7HaUQQHddVRP9+6xIp/OlRaqnoTIIWhyNmLezShGAFtXkuqzYOoHHx6BVYXXttqYGFdHe7VzQm9Z9HD3m+1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752782043; c=relaxed/simple;
	bh=eLhEjhdcSa4FuviVC2h+NoqxxGi3U1iHTnj9BL2JeZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsnbJ+GQ/cDfylzmJScGXLUoDNz0ZwZC3CcrDJ3DMobxbn/6N+PwVHCX0ZCGOJ+vAa6QkjrJjmWJdd4fJgH/ntIVnnvvo8o4LaSBWlWyV+njUBLvEWNNbZSRGdwF6aGwgvd5j12rfGmR9JaWZK9Lr5wxsP4SGT1OttE00cqFKvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIEutlp7; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e8d713e64c5so925573276.0;
        Thu, 17 Jul 2025 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752782041; x=1753386841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLhEjhdcSa4FuviVC2h+NoqxxGi3U1iHTnj9BL2JeZk=;
        b=EIEutlp7MKD822fpMLQuWemcW50BwvBPEct46773ZVuX4PB+gEsPuBqlf5JwXMxcH8
         HtWjra14CDQOzIjIdjIUPEA5Ovzofifg7or2WZPvrGaHGbYx6BfAuex0lkbQ/feoaKDV
         sHC19NmckjX9woFAPzixOBBOvnsZBexUlgsmONaQjOzlUjuw0mIyBfG1qTehPJ7QlrQi
         zMrd+l73GZ62GcbT7ed61WZ6MbyI5dt+Qit7XF0Xtql9xuUiodqTjW6Ab9kAZPWFriV/
         nIc56+4eZJ0pfE8DTyYmZgO8ueIYDi990Vl77Rl9ZXSRHL4DnfBJzlMh1LOiopnqrYMg
         yERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752782041; x=1753386841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLhEjhdcSa4FuviVC2h+NoqxxGi3U1iHTnj9BL2JeZk=;
        b=LHyDxhJlBYN91ZzCl4iVDwogkdab9fOS3Icll1jo53yixXtcE0eYEBTFWrFT5SWfbn
         q54C7U/M9ZxyNueTBp/vwcoRBvNg0Xe6pukmGTcf4oHDU+AuFJRvIkPdFDLxbkVkccEj
         nIysMaTFjYGiiwFkOl7rhEgoFYA760v7qm9kXssd+r9xMeaNnFdpkd1UE0o6XMZGZrDW
         XvSgo8BsNX0OtXs5ffdDo3QTXDtknD76uRWRx9CpBIuxgBXqWZlOPxYEGR4tzVS5DsCI
         qpWTVzOcNMLkg4HMISdkrulc4E0xy6HaudBtr/zADbgOGMI2glsVdmLJF8ns6EMegKQr
         zVhg==
X-Forwarded-Encrypted: i=1; AJvYcCUrJBELqy0PWKAqGL/XFSD1D5VbY89iGqck9u/fpvxSXUjuU9j3s47a6KbIsfgmSmJBNcR+JfqixIhi@vger.kernel.org, AJvYcCUuwDOU5vyuHqZXjFSA853qZ4+OCxKCq7DSN3re7BoDyHY/eZ57tib+EtCI3Kg4B0aVc7HI6VsXp+QuQa0o@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcl3fedsTLyp/VkApa9ZTDfFT/ZzCRLw7sObVAwGe9rTrc70RT
	cuYESZj69iyl8B1A1cJOJS5L7C9RLpB+t+gilaBbOH3OuFqaO/v6grmR0zloYy1zXqb7O8Rm1ld
	IJSnou+Ea6OqHA65Jj6LqkLTwEEKfl5Y=
X-Gm-Gg: ASbGncvDnNObhHrDscZnV4N4EiLoY6poIs1Q/MaoBEWvioMl3mKg77V53MGwJu0KO43
	jxrGlGL1gf6xvoC29zKD1EKCVwOBGBKCwwiSf+gDtIlWPBytOiSNT1l1U6UBZFUeHqslE4MF4bw
	lT8eYmf9wJ+S3pJQ6LeISbfQQUP21RcfHmJPCA/UTqeozW2Y5JI/jkmqZP9EqWH0rcJ1ZxkRHCt
	gnNPaILiMkMjayWbIBLdMwaXDLUcPdN5cE79/2ms2ApfTXv4gE=
X-Google-Smtp-Source: AGHT+IEMptaiU9saHMli+tWmWTvzkXlcE9XiJNrtQ2eFdgPK8YWZPvkdjCTfnG161XyIkWmHqCDjyy+2BgHa6UJVCo8=
X-Received: by 2002:a05:6902:2843:b0:e8b:76d8:6fd6 with SMTP id
 3f1490d57ef6-e8d7a58d22bmr252202276.34.1752782040543; Thu, 17 Jul 2025
 12:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF3JpA7a0ExYEJ8_c7v7evKsV83s+_p7qUoH9uiYZLPxT_Md6g@mail.gmail.com>
 <20250717145911.GB112967@mit.edu> <CAF3JpA6RwyzQMdG4y3P_8jkaS8qUFPerE5MJ8Xecs+VkbPEmpg@mail.gmail.com>
In-Reply-To: <CAF3JpA6RwyzQMdG4y3P_8jkaS8qUFPerE5MJ8Xecs+VkbPEmpg@mail.gmail.com>
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Date: Thu, 17 Jul 2025 12:53:49 -0700
X-Gm-Features: Ac12FXxeXecFpphJU2I1tr9wMiUpO3PxFBJMA_oJH7oytKiF9y0XFH0qv8sqA68
Message-ID: <CAF3JpA5wakELyyOZVYC2MmAoQa9P_nj3AqesZ-PAHN31Omp8Rw@mail.gmail.com>
Subject: Re: [PATCH] ext4: do not BUG when INLINE_DATA_FL lacks system.data xattr
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: syzbot+544248a761451c0df72f@syzkaller.appspotmail.com, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 9:59=E2=80=AFAM Moon Hee Lee <moonhee.lee.ca@gmail.=
com> wrote:

Just a quick follow-up to close the loop:

>
> The current patch addresses ext4_update_inline_data() directly, but the
> same condition also leads to a BUG_ON in ext4_create_inline_data() [2],
> which the earlier approach intended to prevent as well.

I missed that ext4_create_inline_data expects the xattr to be absent at
that point, since it's about to create it. The BUG_ON(!is.s.not_found)
enforces that expectation.

The patch I sent earlier didn=E2=80=99t account for this correctly. Returni=
ng an
error when the xattr was not found would have broken valid behavior in
the create path.

Thanks again for resolving this with a simple and correct fix. Per-site
handling makes sense here, as each path has different expectations about
the xattr state.

Best regards,
Moonhee

