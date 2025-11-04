Return-Path: <linux-ext4+bounces-11458-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B197C32D91
	for <lists+linux-ext4@lfdr.de>; Tue, 04 Nov 2025 20:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4923F3BFC7A
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Nov 2025 19:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5872B2DF3DA;
	Tue,  4 Nov 2025 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl+2armP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAEE22127A
	for <linux-ext4@vger.kernel.org>; Tue,  4 Nov 2025 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762286387; cv=none; b=tE79ch8R85tptzZfF19qNXzdTMQKZ5i+KjqnraeslbZcE4ByqbCv+KgicSgewEdLI/YXsw+6V+EhwCiXpzur/WkDgsDxKYkfifnMFBthzxA2ZpyXwLqWAvRuhI5t7Mo07r//MxSw31XnDnWHrOklydiCuedTbJswzJj6eKOCX4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762286387; c=relaxed/simple;
	bh=uX5r1UKRh5hgHYfFHLXZmC8nv6FyW44YAn4VdccjSK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyxBQxIBX0GxvstckCG7bjjVcGZlb/EqSBSgBXMJH4V0JawTHfrpGr5HFl19Embu1L6NeeY6kXmS0kl9vCWkaneparJ8XzOZyHjWDMRKxTx29kHLTcLvWcxti/N7VWjbeK0129pmbV0AsFmr+z2bmwgf1ywD6SWr0BdCaFBtdFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bl+2armP; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ecf2244f58so56832101cf.3
        for <linux-ext4@vger.kernel.org>; Tue, 04 Nov 2025 11:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762286384; x=1762891184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36eMqKQl+uirAL1DF9qIP4HwS9UCvveHLkgtu9cSplc=;
        b=Bl+2armP1z4USVfymA4A7DLqbOFcGUvKpEyRaJqyXJ4YwCwyLLnrHac7cM5PRz1cpC
         FNLKXUeRv+M6j2owJPWxYHBJ8rEHiXq2lEOnX/C/YTf9oPmmYIcyX+dw45EkVgmAkOeO
         uRu0qVf+5jZVxJhsqjhyMtCCgq2WyFgr6h7aSKoG1tUdt8h9o86SQsQY2a40RsUvyjbJ
         nq6h7VnZraeJVabYrqSTTKPD0XskUgiOVFIdA39IPQBSnN24En5i3Sldv4/GlWIWkrkH
         No+fqyd2uMy1qhyMSesgKMcWQGk9ylO34LZsGrnRHwIU2LItb5zcm0mgiHnRzrIwIwQe
         zRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762286384; x=1762891184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36eMqKQl+uirAL1DF9qIP4HwS9UCvveHLkgtu9cSplc=;
        b=KIehKIaPs+tXs7EEAOQKS5r4EemPwRwr1DSe4Qe+kHDz0NRQb5VPcI+U/l2bQzzv1N
         Wme9FOAwXLao/OrYhY6rTeakcmDPmiFgIQsjYYx2u+SezWHnsoRop1z0ZJVOzcVbk3gY
         YvGradaK2XkdAJoMJIjS6d+ZC0Q3y8TnwUj4rtjftXVG+5Q5P7ig2SMqTch0GnJV7RuR
         XQ4wM+Lpym83ZIrjoKGHgsiT1SufXgB1b4vWgEn7HNLPqnkr/PeAaK/cP3vBdcFtFrpp
         2v6QsJ7L9Aq838cIYUxOvc0f4uUqU3RIWuFnxYmxWS5UZqqL2yrG8FKcdvxKnDc+Wr5s
         hbAA==
X-Forwarded-Encrypted: i=1; AJvYcCWOJvwcDKcuYMOvR2am8w/xg2dy8WFBg3cIuBRhCHH0H+RdEuGrLA1BVX2ncXILjv6jz2eR01sESmFe@vger.kernel.org
X-Gm-Message-State: AOJu0YwjNcVk+BrSUDn2z/15XnV/ymLFja0xGyA5cBYDcpW7HaXZDgk6
	u8pELhSuv1ZMIRnspg0Nob6fMyRqhseNWDWOtzMSgydSmHWsbFkI9hU2sWbobt3igve8YRYX+EQ
	CZAAVWiAkhMr5DfLG+q7RYfaz2T5uKSNhIA==
X-Gm-Gg: ASbGncsC/6waHP9NjxlB+iu8rHWj8KUxgQiWFiY0NIE7+QqkbODVuHXlE2ShjOuAExa
	xIMAFTylqXw3njw0WDH7jAFQJCX0S/9anuLd1W9tZp0iDhc799DfUZRck/JZMiBzEnV9fSj0Ify
	hnmW03oO3TRrE6OJFwaLlq5qYXk4Yp3tSRzciKp95MTgoUu5MyFWE0plxrearjJPpzCLDLVO7/y
	IUKzZ3MWqOXujBO1EU82RRvl8vlJ7QFzZ5l8a7wzNSKRltBw4x5bsW7oBEoGKbTY6GXvGHZI1U1
	hI9pL8xXgQ95SCrFZEi7Ovl2u5uPuREN
X-Google-Smtp-Source: AGHT+IFYUEk67d6wkrel09WbcgZrushIXlVlBxALy1cPC783ZW824tJLnztCsyN2ea6YD8lujb+bG2kRyCR6kw7wRfk=
X-Received: by 2002:ac8:59d3:0:b0:4ed:6324:f53f with SMTP id
 d75a77b69052e-4ed72626098mr10004961cf.39.1762286384520; Tue, 04 Nov 2025
 11:59:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs> <176169809296.1424347.6509219210054935670.stgit@frogsfrogsfrogs>
In-Reply-To: <176169809296.1424347.6509219210054935670.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 4 Nov 2025 11:59:33 -0800
X-Gm-Features: AWmQ_bliLv8l5EMdKsrWCti1ZZIHas10dyMFCTrkaG3nWk2BbLH5E6LmnFVgPEU
Message-ID: <CAJnrk1akz4YKkB_rywe=9bPn8Uur-WS4f6hCxx2K7kXuMeEJJg@mail.gmail.com>
Subject: Re: [PATCH 2/5] fuse: signal that a fuse inode should exhibit local
 fs behaviors
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 5:43=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Create a new fuse inode flag that indicates that the kernel should
> implement various local filesystem behaviors instead of passing vfs
> commands straight through to the fuse server and expecting the server to
> do all the work.  For example, this means that we'll use the kernel to
> transform some ACL updates into mode changes, and later to do
> enforcement of the immutable and append iflags.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

