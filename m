Return-Path: <linux-ext4+bounces-5950-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D822FA0379B
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 07:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B7E188661A
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 06:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B131DDC04;
	Tue,  7 Jan 2025 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdSg9R39"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1DF194C9E;
	Tue,  7 Jan 2025 06:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736229836; cv=none; b=p2i52YbyNYzryA1KbWr+yoUVWRCuP/shgq/UzEKeRJsqqF15yglX45Zw2F9xj+Ien5i1+1sz2JRaQlD27UZtJILZXbVt/AoR4F7q8ohOD+H8RwLqn2O3QE+5i99j02u5gqdWFcNVzfFyGNPG2TpTjWKd4oj4AYXlPlXJLbD/Ask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736229836; c=relaxed/simple;
	bh=ctlXcpbsNo1VWKDdZeVUFFRQIbgWBhmzME6YEDpLe5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQsyjKEDqLGCGkd9BQ+tBdHHDnUEayxBN9Q8a2qMIhcfG22bUExtKfJrAS1LDgxyMKRoAs/DNtE//6POup7vs+lI4I5QmlEw3IzTJZvC30cjcWu/SGzGLLpKHPuDW4tnnymltyjugP5w6LdRCGU1rA5rv6W+4sEJPF9WQO3ec3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdSg9R39; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5401c68b89eso18350857e87.0;
        Mon, 06 Jan 2025 22:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736229832; x=1736834632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rqxy+yRnQHtDHF3ajx5P9084bEHkkk0uNTrwQ9uHws4=;
        b=jdSg9R39ndC0UOzIYSANuJN+pg9gXyQSyHw4saBXhB8nWeO7LRuBS0F+IpjaMVwp9v
         Oc3TeNHieX0Kevw9nbsjCLFxJ/iQAdIbHWpthQU5vy2DMW27u29ssVtqXfb63Uj0IqFg
         rnXxs605qLOLWMZBIOesYHi9gwDNZ1bavPaXKJUpkGDNNrZILnztkwYXT73+7tYwy79z
         V8py5AJ6WErPkkYAT9ef1A2FYNRbmqlZbs4hMZqEize8b5ZJbZ4CwYsJU35rx0ix3Vf3
         rFK0Cj3fY61lf+fA1LF8QLF2jhoumcQmoW0QR0py3sNgOpCyR27VqRxb0OXOOEyCCJTF
         Fpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736229832; x=1736834632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rqxy+yRnQHtDHF3ajx5P9084bEHkkk0uNTrwQ9uHws4=;
        b=FORAfnv2U6DTkHgxwo1IUlxFPNet/SI29Lavp8pz/DzTuCTIJxYlzhZRv0OJ4PABur
         sJjCb1mYypgDcLHx/6jc1g8HRwg/YRAEp3p32bOW2YHCsO4Ufw8mLvZm0bJOECLwIN1O
         Aul8POzGyiJeGz1b5dtJcd5sLR6zqrLDeLTzhaTk45Ag+nsD010q6iFoPm7ZjX5QKEbQ
         AK9bj+yYIvcuO06CnwHY5SMDhyTjYapQKC8HJvb+syZlzy4EecxHB5qCi+qbat6Tob8Z
         sPREjpgR9P0hfZWrhSCX08XZ4O2VgyPRWuIki/V8MW2aOAj4RaT+ftRzDTPc6v94xlGN
         xarg==
X-Forwarded-Encrypted: i=1; AJvYcCXwmqWl2etydtEJMYa0OcVhpd2yl9kVL94TIDbsvGnRPnDJooi7TZcKZTTh5boknItuEI1sDibRMNaD34Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHy7lJ5giqjgLl1EaFugZ4qjPc6FtRfi6+NJaJAEDU3LW//U6b
	cgXOrLoFFEl0sF0S+TGMQTwUywXriFtwM8oblkfjfT7y54PawdFSayRm5TtNBwwOfQNcUcwWWUv
	/fS/RInRKLSbayaUGRmQ0lpk3rSU=
X-Gm-Gg: ASbGncswTHiAFXo/SENF2wxI57PDAkgj51hcWr114dlH7QA9t5tPw+BDUIYwUC9r9iW
	m+LllL8sew9U4QS39bhosUwS+oM9ExiGO4yx2sNM=
X-Google-Smtp-Source: AGHT+IF6q/Ydt8CmGz+z2GdtTfqZRc6wTUIREZOMAKo/QIx3uaiIBtW6Je2QjS9CD0gs4mgIPUT2lJU3C0DmRBv2DeQ=
X-Received: by 2002:a05:6512:3b9e:b0:53e:2098:861d with SMTP id
 2adb3069b0e04-5427e981c5emr481212e87.15.1736229831402; Mon, 06 Jan 2025
 22:03:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220151625.19769-1-sunjunchao2870@gmail.com> <hcnrjqr4pat6mzp4clxoeu4fuzuldks2qry5ropztfu4makhqe@x5gfsvdgl2ik>
In-Reply-To: <hcnrjqr4pat6mzp4clxoeu4fuzuldks2qry5ropztfu4makhqe@x5gfsvdgl2ik>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Tue, 7 Jan 2025 14:03:39 +0800
X-Gm-Features: AbW1kva5hVQSQRUqB7faWwa-AeXSjrS9nzU0HprNhNkn3P0tpxQ1gdgofq3pIPY
Message-ID: <CAHB1NajUaauYPBwOLt7QktbUGrONBHZpifGy50u77y0Gcom+cw@mail.gmail.com>
Subject: Re: [PATCH 0/7] ext4: Convert truncated extent data to inline data.
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, boyu.mt@taobao.com, tm@tao.ma
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan Kara <jack@suse.cz> =E4=BA=8E2025=E5=B9=B41=E6=9C=886=E6=97=A5=E5=91=A8=
=E4=B8=80 23:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri 20-12-24 23:16:18, Julian Sun wrote:
> > Ext4 provides the feature of storing data inline and automatically
> > converts it to extent data when appropriate. However, files stored
> > as extents cannot be converted back to inline data after truncation,
> > even if the file size allows for inline data storage.
> > This patch set implements the feature to store large truncated files
> > as inline data when suitable, improving disk utilization.
> > Patches 1-3 include some cleanups and fixes.
> > Patches 4-6 refactor the functions responsible for writing inline data,
> > consolidating their logic for better code organization.
> > Patch 7 implements the feature of storing truncated files as inline dat=
a
> > on the next write operation.
>
> Thanks for the patches! So ext4 inline data feature is a bit problematic
> and has some locking issues in the implementation which we didn't manage =
to
> fix [1]. We are even considering just disabling this feature due to the
> complications with it. Hence I don't quite like further complicating this
> code by adding possibility to create inline data in an inode after it had
> data blocks allocated. That being said I like the preparatory cleanups in
> this patch series. These are useful regardless of the feature itself.

Ok. It looks fine to me. Thank you for your clarification.
>
>                                                                 Honza
>
> [1] See our attempts in thread:
> https://lore.kernel.org/all/d704ce55-321a-9c1d-1f8b-3360a0fdf978@huawei.c=
om
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

