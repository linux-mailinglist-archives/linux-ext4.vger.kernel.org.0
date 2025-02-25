Return-Path: <linux-ext4+bounces-6566-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD803A43FB4
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2025 13:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D623B60D8
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2025 12:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45C82686AE;
	Tue, 25 Feb 2025 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVntvlI1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07B5267B7A
	for <linux-ext4@vger.kernel.org>; Tue, 25 Feb 2025 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740487997; cv=none; b=TKSaumUlJ1JF5uyOR6+yBBdmXd751nGmaXD2sfvn8xqasE+Eb4XPnk/nosWtknUGBpBIHT2SgRujZUAiWLdw0fyIXk+uxENMTLSMfaZxziN0ujebCrrUgAGqkWUuGouiGBOmZFweyefarpoGCRXf+Nen0biHqrdIbJ6UAepbFBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740487997; c=relaxed/simple;
	bh=+foFzpuAgZcaK0fPcioj45VFYvSyRVifFyAagr6zsVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Tnk94h+Fjc3qOoC+KCYaGvivF37lr0XkFmyeN5jnD09ZiwOqqCOazBFrC/8+MIWBR1eCOl0X7vOxwd0dWjxRHdhxccAdQomX7Z8COb4m6NDygjEB2ULNYn2lkKkgVwuYnvHmd3HEK05vwodLq8kPrUwkn4kWrAd7LrRF4k+P7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVntvlI1; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6fb3a611afdso46258017b3.0
        for <linux-ext4@vger.kernel.org>; Tue, 25 Feb 2025 04:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740487995; x=1741092795; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3N1fm9wWU1KStkLmXq1XGbtXcjUjw9sQZp+tJS4nxs=;
        b=EVntvlI1V5F/Ou062aQNNdhZOLYsli0eoNitooRaU8f+AYBIiADn+KmE2sY/L7iJl+
         Rcl8/YrNQ3pvGfWjqedALqNX1KVWV+v7rrIPYF1OMOUb/I8ucxtk8DH5tuNjlJgis6Uw
         3XbdDUb8nBgoXPmwg9V72URdrLKI2L22Ip8qAEdFtQm1Rmau/YizrlZixhvIcCQF75Cg
         gEcZav5Bqyx+hyPx9NjFWNb33yD5qCe5La/Xfnb91ps8Px+YZidZMIP5V++JvvBnvpPE
         PuD+yVoB1B5NsCzXFWVG7l1xC+fKB4O1fzhUNBmmiocbm8bZX9YFyaxNwuG1n5CBXyZP
         b3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740487995; x=1741092795;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3N1fm9wWU1KStkLmXq1XGbtXcjUjw9sQZp+tJS4nxs=;
        b=oeXA1+lnEO7VSnarEzRn6xmLVdyJjq1IprvJCAbUmROp3bXmj3GKegXRJMfKbQM1Hb
         pSTm+91eJreq1kzd4AQ6ELVfEMdkVp4qZXIph6uNQZZzoXSi82+r/mJVxpCkDYGfgohE
         ed99erfyaoER8NkK7QmXUI0/TeU7FmPo0TnqZJeg+tOeYcjtb0rH75NL9L2lS9+CWXQA
         CtgA4PrTIrGkBuLyP33I0KyQKQIdKO26OnP5ITvH40nYQFYeoXY4PCxbW+SL319mEgsh
         WZe22MfUEB7jSD2eO7Kwi70rwvjkM15KJ/lozFzaGVOqYH/3Rt/72pWHdRFT4UmGsv1o
         QxRA==
X-Gm-Message-State: AOJu0Yxpd4HOX39qoXwvBt81FierRqwd3+WPEaUEtgp0LrxLKdVHr/se
	hkB6bWCuYgTqnvbSoRalTtfzcclsZPw9OoTPvUbIxGy+CPrQbD48jBqxIeW60Jp1cD6sJWfXKen
	k1du4/5hjXYLJFGFU29Y403kn0zn5WX43v0I=
X-Gm-Gg: ASbGnctoK4SYGVO6cYc4XO9HLaAWy9TcFlo2UjWbNtdYlNftphZSOLssApBmeF8uBKE
	gtG6en6+mf+dfpVbikeMyZiTHDJ/+et8gd1TRt18c2GxCKx/4OCzdR9IxCC2whYDQNdhCkaz08N
	VJGD7Grw==
X-Google-Smtp-Source: AGHT+IHtm1MlQFYEum0G9tnfINku4okK2F29C9e441dJlg+/eLVR0dLh/y1F+ju0Z4op0wVz1Hz75yNhVlHsXtRbcuE=
X-Received: by 2002:a05:690c:6502:b0:6ef:4a1f:36aa with SMTP id
 00721157ae682-6fd10a16013mr29083047b3.20.1740487994642; Tue, 25 Feb 2025
 04:53:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD+278W-BG5tNPBJJ=gYwyygrotk+58-OCmv_LfsgHEwSAPEVw@mail.gmail.com>
In-Reply-To: <CAD+278W-BG5tNPBJJ=gYwyygrotk+58-OCmv_LfsgHEwSAPEVw@mail.gmail.com>
From: rsingh <rsingh.ind.1272@gmail.com>
Date: Tue, 25 Feb 2025 18:23:03 +0530
X-Gm-Features: AWEUYZmiBskCNR2P7lUHRvwWb6gWnCiISxG0GLFTGwxlPk1XhD5IMaUCVww9z-w
Message-ID: <CAD+278Xkq3WiHWG76u1NzO6NSi5p3O_CEBRpG8GKBny368HsOQ@mail.gmail.com>
Subject: Re: Doubt about race condition between fallocate() and writeback path
To: linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it.
After acquiring folio lock in mpage_prepare_extent_to_map(), there
is a check to handle the scenario of page getting truncated.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
folio_lock(folio);
/*
* If the page is no longer dirty, or its mapping no
* longer corresponds to inode we are writing (which
* means it has been truncated or invalidated), or the
* page is already under writeback and we are not doing
* a data integrity writeback, skip the page
*/
if (!folio_test_dirty(folio) ||
   (folio_test_writeback(folio) &&
    (mpd->wbc->sync_mode =3D=3D WB_SYNC_NONE)) ||
   unlikely(folio->mapping !=3D mapping)) {
folio_unlock(folio);
continue;
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


On Tue, Feb 25, 2025 at 4:57=E2=80=AFPM RSINGH <rsingh.ind.1272@gmail.com> =
wrote:
>
> Hi!
>
> I had the following doubt related to interaction between fallocate(),
> write() and writeback path
> Can someone please provide insights?
>
> In ext4_punch_hole(), writeout of dirty pages is done before acquiring
> inode lock as shown below:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> /*
> * Write out all dirty pages to avoid race conditions
> * Then release them.
> */
> if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
> ret =3D filemap_write_and_wait_range(mapping, offset,
>   offset + length - 1);
> if (ret)
> return ret;
> }
>
> inode_lock(inode);
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Isn't there a chance that after writing dirty pages and before
> acquiring inode lock, more pages can get dirtied while writeback path
> is also processing the dirty pages?
>
> Regards,
> RS

