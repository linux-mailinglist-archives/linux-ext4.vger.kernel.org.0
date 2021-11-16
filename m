Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39594538DD
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Nov 2021 18:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbhKPRzy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Nov 2021 12:55:54 -0500
Received: from disco.pogo.org.uk ([93.93.128.62]:29757 "EHLO disco.pogo.org.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239119AbhKPRzy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 16 Nov 2021 12:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pogo.org.uk
        ; s=swing; h=Content-Type:MIME-Version:References:Message-ID:In-Reply-To:
        Subject:cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KUG6rbZAMH02/lSbJm/Qejp11AVYHnyL8EQRK1oA0BY=; b=KRqvD4hc1tdWWz+BmBx89BNrzO
        ptoxRg1zHJNtXu7wtkjlKVNImNsRG11oR3eu50w50VAcGIdc74TfT7yvolvEIfRU4QjED5dRXEQWy
        UKOiVvfYKJEjplt58/t+CLVJe/aElpP29x3qyjJBtyqCT0LVejbuvXgf0t0mJWt5IDbo=;
Received: from [2001:470:1d21:0:428d:5cff:fe1b:f3e5] (helo=stax)
        by disco.pogo.org.uk with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <mark@xwax.org>)
        id 1mn2db-000MK5-ST; Tue, 16 Nov 2021 17:52:55 +0000
Received: from localhost (stax.localdomain [local])
        by stax.localdomain (OpenSMTPD) with ESMTPA id e8c2a489;
        Tue, 16 Nov 2021 17:52:55 +0000 (UTC)
Date:   Tue, 16 Nov 2021 17:52:55 +0000 (GMT)
From:   Mark Hills <mark@xwax.org>
To:     Andreas Dilger <adilger@dilger.ca>
cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: Maildir quickly hitting max htree
In-Reply-To: <82C9B126-527B-4D41-8E01-84C560E06A3F@dilger.ca>
Message-ID: <2111161748390.26337@stax.localdomain>
References: <d1f5c468-4afa-accc-7843-83b484dc081@xwax.org> <82C9B126-527B-4D41-8E01-84C560E06A3F@dilger.ca>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463793916-1319953200-1637085175=:26337"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463793916-1319953200-1637085175=:26337
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 13 Nov 2021, Andreas Dilger wrote:

> >>> On Nov 12, 2021, at 11:37, Mark Hills <mark@xwax.org> wrote:
> >>>=20
> >>> =EF=BB=BFSurprised to hit a limit when handling a modest Maildir case=
; does=20
> >>> this reflect a bug?
> >>>=20
> >>> rsync'ing to a new mail server, after fewer than 100,000 files there=
=20
> >>> are intermittent failures:
> >>=20
> >> This is probably because you are using 1KB blocksize instead of 4KB,=
=20
[...]
> > Is block size the only factor? If so, a patch like below (untested) cou=
ld=20
> > make it clear it's relevant, and saved the question in this case.
>=20
> The patch looks reasonable, but should be submitted separately with
> [patch] in the subject so that it will not be lost. =20
>=20
> You can also add on your patch:
>=20
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks. When I get a moment I'll aim to test the patch and submit=20
properly.

--=20
Mark
---1463793916-1319953200-1637085175=:26337--
