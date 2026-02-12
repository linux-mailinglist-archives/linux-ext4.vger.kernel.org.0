Return-Path: <linux-ext4+bounces-13679-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNERGF4qjWl8zgAAu9opvQ
	(envelope-from <linux-ext4+bounces-13679-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 02:18:22 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CDE128ECB
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 02:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE56C30B241C
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 01:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215DF23717F;
	Thu, 12 Feb 2026 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4PbZEfn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2F226CEB
	for <linux-ext4@vger.kernel.org>; Thu, 12 Feb 2026 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858885; cv=pass; b=HuapII+FhkJqDnVVFaPBPDac8I46LTPiVli/vosWAuty7hpZGcJ7Itkk69uwNrcTAbJpTCh4W8QmzCqL9nWW2CvzHO20x3UFFDs34dHkeLEKRz7l6FTOQQF+NSGVqoiAXjkro0bX/kjoecCAQ+Rl9eMCWPcPkq0LpNxZb9z90jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858885; c=relaxed/simple;
	bh=ukLfsVajvOFxj38PQtxW0aK5YrmphSGnllz5uCb339Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlmoJeMKFaNJ/5igtb3oMc8WClxFrw4WTgD1k+UUQwbx/Ai+3nHKddgq/WQOyFYtPcNi79wi3B1Mdx/MdPdTsbzDufJnBo8QELaTLG2NpQja9hRdG0iS+DlOha1SQmFjQm8ghgSrGC42HRXUQYVDJPo6/Wi8xU+oEbzMRZoIibw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4PbZEfn; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-649d4c77a32so6953983d50.2
        for <linux-ext4@vger.kernel.org>; Wed, 11 Feb 2026 17:14:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770858883; cv=none;
        d=google.com; s=arc-20240605;
        b=NepKKK018RUXlYOq6juBLSR8NloU8n0vm3w1fw6OP/VdqX5zWVY3eYTj6G5KybciEG
         MlpM/2f9fffJwgLswdspR5p32zE8e2ChznOdd96x0L1aul69rVdpqZ2Bwj1fmwixeW82
         ScyFiuQIdaXBhZwWDQhsq4nTyJavqPBT7m5y57XMD0LzFpmwatkIMp8kjvZw7cRe6HUZ
         OB6vt30sn3a5rgNDk+5gjPo0jpm6pCkDR1zTKjdI7H7IPmoo9AqLEXk2gboVujmJZUV1
         6CJOA2HDtheMe9SrkhGbjuRvW2Te0mcGlJc8NAda1fRceantdlK2mztk7uNUFkTxBIrq
         pU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ukLfsVajvOFxj38PQtxW0aK5YrmphSGnllz5uCb339Q=;
        fh=DBn49HQkvdPks6VpiZ3IJd/XumX9A/fQZGaVfshwUQ4=;
        b=OhPCCDHvhytPF9moigNBksVoX3g5l2BL5O+elSOxg4SCXpExZe5DL+EcWNVsdA9uMk
         S0KER62/pRziybzTtZcO2Kg+bihOMXdT8NN4UjeejLI3jn/1q4GZe5R2xBtEraM8FPya
         iEJf/hxHyMSFiAh9VpckqFmadFT2JJLhspvN4mOcljONTViBvlLtOCQpTTRAHpsDdTHP
         AETgjXpNOgwW05ZDU86MfFGFztFSBkZgSEn3zHoxgohxGypYIEpRHxMOzvWIR0SHU1V3
         KyIyhLdO29gzi8Ws8oywYPOcb9xe1XpZ3U36KjbD5vNJYnx0JpL065tBSDT0icPDEKIY
         H+6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770858883; x=1771463683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukLfsVajvOFxj38PQtxW0aK5YrmphSGnllz5uCb339Q=;
        b=A4PbZEfnYjK9JDt2Zl5KlR+owiO5LwfQrYcxr35p1Bh2FlmCA1rhOSk1vGiEz1vOuP
         wA4oVxNmkamnyL/PYHH91erO2p3NI179mxkVFNm+L1fneG/Bbk5NkqrRwwtlBkmfzeMQ
         OWKPGjnEal10eM+t6l1sOc+LpK+phACbux7g6uqw9rTElmx/nkGyDZhV6vogNnieMx7H
         BS+1dnbxPeZtTYjUC8gM8wbAcpPaTv8BLJykugQ++Vr2FeHJkyAW/yg35QOCEAZLMrTI
         k4iGlRxsDuVYjnh8bAkv420nM27LwIDfrUeDqHTRZY4D/RkIngDBt4iSRtXbyaWpx4zK
         EzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770858883; x=1771463683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ukLfsVajvOFxj38PQtxW0aK5YrmphSGnllz5uCb339Q=;
        b=xPRaJbrK3z60JG5Zyq3Njy8xdBnw+6c7gOEWX6jLIRwT4KI4GmnLtbw4dqIV614gg0
         cfxRuCU597ai8EOhrJUj4unPZcO4Bjtn8K9LKu7PRU6bIX7qRFbrPGB362ZTEzOZY4mY
         1qQ3wO2SGm2ej0ayqvtJSIc/9hI3F9EAf1szqzm7s0fhaXmgFAF/KIpO3f9fxBA+4PSK
         6aB98zf3xxLzg72l3TAp2QVGJ6II0cVlrG/ntap28KVLMxxhjXLsMFA83+h3oJkSYzct
         /kUldbd6Mj3hU1kpjVJjtCyIhcbk/Z224XLb45F1FAcSby8F3EJuS5WJz2iMtXDuNz6y
         m+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoUdiEilCRCpwxq0Nxr72OYzSZPuVun8VBs3Hu/fjpRmiSewTYdYvy/TUcQX5iS4qdWWL/EXcqzGfa@vger.kernel.org
X-Gm-Message-State: AOJu0YxWJHt1iI4iwlaPKIxnD/B85lAIojEPfiikEqd/VEvuxM3VbrPd
	uU6G5sccIBKostO1k3LZOKaeGNACaGnl2pxkKV+HlT2z5lNSXMrHGK7mb+89oZM2Q4NQHSINFDh
	Is+fOv5+wCbK4tNNWl4TyAshDLrddHIdW9Wx6
X-Gm-Gg: AZuq6aKgNDxQNnUpO3YmG0iaSqGwk888GJyuzTps0OrK1ay9V7WhMNuAK+Zsl5O5f3G
	Cxq5zUcV+GUd012lh8O2f71PuUdmTQfD8Z8I+nYto4lvjsborgO1JhSMU+IgXAJLWX5C8Sp9Y2O
	cgNbHmYrUWUxslo+YOOdbC3wlES6+6UUEN/+IZ2MRJIWKOmfJVawJsbiy8ch6pv6q5WXMVa1YbH
	TQRTQv8N5A12MPsYdVJTM3LuOQ0Z1fV9p8UxS3kN2c3cp6488BewSItbAfORRX3X/KU7CpB8v4P
	JzdSq5ugSw1hHLORZPx92ONPU3vdEHwvueZ5/9jQC3C2x4+cPAjVOY+DZpvoIAxp/Qcf85KNnub
	nwAhP
X-Received: by 2002:a05:690e:48f:b0:649:f0e5:fab1 with SMTP id
 956f58d0204a3-64bbaa483f8mr928298d50.23.1770858883542; Wed, 11 Feb 2026
 17:14:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207043607.1175976-1-kartikey406@gmail.com> <aYykSCvhtYRGxCi3@infradead.org>
In-Reply-To: <aYykSCvhtYRGxCi3@infradead.org>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Thu, 12 Feb 2026 06:44:31 +0530
X-Gm-Features: AZwV_Qhbw26w65-_qbehiXP_5-8fQ2coGwCQum9ABrGzCY2RDJB2xkIdeq9j3R8
Message-ID: <CADhLXY4__=t98fVLP15vWVPyBnfkevnERBXRwH+A20KbeNSS+Q@mail.gmail.com>
Subject: Re: [PATCH] ext4: convert inline data to extents when truncate
 exceeds inline size
To: Christoph Hellwig <hch@infradead.org>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+7de5fe447862fc37576f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13679-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4,7de5fe447862fc37576f];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D2CDE128ECB
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 9:16=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Sat, Feb 07, 2026 at 10:06:07AM +0530, Deepanshu Kartikey wrote:
> > Without this fix, the following sequence causes a kernel BUG_ON():
> >
> > 1. Mount filesystem with inode that has inline flag set and small size
> > 2. truncate(file, 50MB) - grows size but inline flag remains set
> > 3. sendfile() attempts to write data
> > 4. ext4_write_inline_data() hits BUG_ON(write_size > inline_capacity)
>
> Can you wirte this up in an xfstests test, please?
>
I will write the test case and share the patch shortly.

