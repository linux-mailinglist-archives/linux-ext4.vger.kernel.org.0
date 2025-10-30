Return-Path: <linux-ext4+bounces-11370-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6219C21409
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 17:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A7B3ABC78
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 16:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66BD36839F;
	Thu, 30 Oct 2025 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkQ7jJRN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0217366FB3
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842139; cv=none; b=CJ9etQ4TJXrlgM+1Kp1auTl1g1hsFhtlryfvcMz60DZiLqrYOlyz7ItiMjWbtbxXj37Xye3y9vCo4Y2JDMLdKAic1vRvouVBRQDmDVN4BBXbRN9XjaAbpycPsLdeEBxHe92RDlanvsJVQCBxintgMcOOFgUcmzO1mN+WyBkcjTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842139; c=relaxed/simple;
	bh=GiEHRyaXp9kfjnsMVeELyagLODegv/P5PKlxzj9PbaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QoEve8QMq1PM0hhP9Fo7z+9NYVP/X+MlN0OWFL6ZvRnBYvaC5HdJudGOeeRL/b5an7IwnzolkK1jMlEq2g8e5HW0xfoYZUCJnzw0Q5n1tDjiSjI0j4fbIqlCuAzS8xbwzDdo3fqto7RqCGy5BeshFutVDTpNT8FenB9uYNPhiig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkQ7jJRN; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ecae310df8so18750751cf.2
        for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 09:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761842137; x=1762446937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5o4K9oNCLwDQNdBtR9y7piokAlSHHAjr/7AtMAPadU=;
        b=fkQ7jJRNmg3/B+YzGh9j5cyY/VkJbJdoq+TQNBws1lTR6845RvpFSjPfRH3ANRgYrV
         4KSfuw6wmrAotfzJb8wwYfeCO/tBpVPHpVmIh/ZuNbu6v8Lw68kFB99A6mvDAb/4gZ0Z
         hd/2ZRx5PtIh8bY+yMkT10N/6oRibK3A1ZQQU4nG1HU847wPnAxT8vTomTy66Roknqr3
         I7v5OJB9Rm4eicq600ySWi1KXZ9u9ZiL/rVJNUGY25QfEC2H/34U4jEX09wUn5jEuhIB
         lzoWJ9Nx6YyszGEInbU0ep8lnf9UH28QJeeQST2pvYUPjDabOrNKQimK9+0flyd62s+8
         WH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842137; x=1762446937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5o4K9oNCLwDQNdBtR9y7piokAlSHHAjr/7AtMAPadU=;
        b=W/qmiFLu0I3HX08lBt/l7OBslpeYiai9JRcrHqOSGZGf4YJMEBVG9xTj6H1sG3xQc0
         doRZLUlpDkFaJ5OUTRdXHFCmi5jWQjhs+pQtlmEEYgNRNoud0B7XY1/PeMkACXcndtfM
         Q19gT+uQ/IPCjr3W9VTq97uOLE12xdaWUNE+GaQXbOwRgDLT6WcCVDbKnQgByQohLJ17
         PXHUU6A1paB0PXaJepH6fU1WA5diovcwbq/bPoSvbmlFql5o04O6rprkZLWaNpnWQ6wq
         SDDhq2PH8thyasC6DU0gQVZVy5FhTqwwgTMHy5OEONuMn1ko4lpSZ9fpLo4XS9CVB8oq
         Rb0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgLU2hpkG0DM+9wms2yYxZlJbxrdj11htIv2v3i3ekpFnqjvKOE8bz4c5O3FUqdLXGIRB8Pd4Pnmt9@vger.kernel.org
X-Gm-Message-State: AOJu0YzVcdlS8EG4bSH+ADrMWocd2CvRAEG1rH5evwXT+cbF2W/kr05p
	/TGCNbfLLNwBZ9j+tWhpAt+XVRTGw2ap46MXDV31Xtsdq4FcxRBrrI52ajT61dKzM0q8NwYCP6H
	J3Cgj6OyxTDd95IaaPmHXqbzLgnArkNoAjw==
X-Gm-Gg: ASbGncu/aFcF1623qVgHZRrLl/xCV4u+ttShKwcIqMs7JQyxJTWv8wF9ttZyvnnMsVU
	J/2IFl4oPFlwq+IqbhbKj+pHzcRaZnj8PCQHNq8Thn4Qpm55x5NxTJumDekBGn9Cf6EqEgHRe+r
	4R/WRn8FSbjOXjRThazNLwfkFQaRIHfgCP4FVLod2pwbA9B8qVgBOQNEJR/FIDPnIe8xdRek8gc
	Ai5Uz4/CRrzzoWy56iT5Q1VSZ0n8R/dQQJ1NdTJSm0rWSgSprqETp2iPFs/eKwpL7BVVqdefgNV
	6MLfas3NWdUWm6c=
X-Google-Smtp-Source: AGHT+IGiAkMulyU0/vdSGD60VmaWb3MA1BBjAhFxOLtQy2XsbodrFJtTM0TloG3KYKGHYL2xrybIPJ/yN6ys1MeKDjk=
X-Received: by 2002:a05:622a:4d92:b0:4ed:5ed:2527 with SMTP id
 d75a77b69052e-4ed30d84774mr3656181cf.3.1761842136634; Thu, 30 Oct 2025
 09:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029002755.GK6174@frogsfrogsfrogs>
In-Reply-To: <20251029002755.GK6174@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 30 Oct 2025 09:35:25 -0700
X-Gm-Features: AWmQ_bnhtyoyNeiZZhSDs1-KjBCdyvwVIvxdX0oPebRsgw9NW9oQZluPscntiBk
Message-ID: <CAJnrk1YVjB2U6HSHqkjqCc_6i-Vzg+Vmts_KV0yaa3KG6TN3pg@mail.gmail.com>
Subject: Re: [PATCHBOMB v6] fuse: containerize ext4 for safer operation
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bernd@bsbernd.com>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Neal Gompa <neal@gompa.dev>, Amir Goldstein <amir73il@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 5:27=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> At this stage I still get about 95% of the kernel ext4 driver's
> streaming directio performance on streaming IO, and 110% of its
> streaming buffered IO performance.  Random buffered IO is about 85% as

Do you know why this is faster than ext4 sequential buffered IO?

Thanks,
Joanne

> fast as the kernel.  Random direct IO is about 80% as fast as the
> kernel; see the cover letter for the fuse2fs iomap changes for more
> details.  Unwritten extent conversions on random direct writes are
> especially painful for fuse+iomap (~90% more overhead) due to upcall
> overhead.  And that's with (now dynamic) debugging turned on!
>

