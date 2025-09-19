Return-Path: <linux-ext4+bounces-10301-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C12B8A5F6
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 17:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F267E4BC8
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 15:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C1631D36C;
	Fri, 19 Sep 2025 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v6ipM70y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FF631D36A
	for <linux-ext4@vger.kernel.org>; Fri, 19 Sep 2025 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296670; cv=none; b=UoeQWsKgml+4d+65bmYzOZi/MMTaG4cnKPTGOSa/3WPWnxuJ2cLF/Qh6dj1E8ckFIimbEwgFcVPzx/8MrbwB+ypSAuLPduKO0KnsF8maDGIxNQc65yJNz82VPmNziCamO6210NptMqPs6IIa6nZnSu6xm0YeF2tfAJg0mIDb2iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296670; c=relaxed/simple;
	bh=TsbVwx2DDUPGBVVrPMa5S2QS60xGB2A0ufyLFVby92g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9Sp5fDx+yDX9rM48JCkKL6F8ISf+A2oko/Yz1dtpBZ4cShjjPYX/glGofTH75bLzMn8OG3cL5oqk2XcONR3hYImi26j5DgO10vSlbCQ//sbsQgNF2yQPTCpPkKSX7YLj33L6xnLjFsvfYRln3ZxFaqTeF8LaUfGDTwcBz1+W9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v6ipM70y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-244580523a0so25150965ad.1
        for <linux-ext4@vger.kernel.org>; Fri, 19 Sep 2025 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758296668; x=1758901468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsbVwx2DDUPGBVVrPMa5S2QS60xGB2A0ufyLFVby92g=;
        b=v6ipM70yjiLgVshKm316hz7p45Gscy3FAW+Mxzc+Sg3X7yydawZdFxFJdSFxAOB8t2
         Td9svDY+v4FJCdSLWlxI8mwx2UbQyHEWjeDhUB9M3LSDqt25ts4PjeOELTNKmfLjAalD
         am9FyYSEhoKSxDK/7yhdm2g8ZdWUz9eNM5Mmp/3nFCEdc/7emGugZWEJx7NZa1vky20Y
         bGnY6K2ejpccBCtkneGS2I0Y9LViR7SIIH7B81cTynge2E2Oyp+3sBjHjyPd/l0YUaeB
         sHwst1OcChnBMRmmwG1DSjs21qslNdnciXbuD9llcthzJJvKL8q/eF1szSHeyn67w0nV
         d/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758296668; x=1758901468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsbVwx2DDUPGBVVrPMa5S2QS60xGB2A0ufyLFVby92g=;
        b=ZVUdpHRUwHR9N71L2IwK6kcBdJNffWOe1EF51qa0G8IrZStQbJXeQcIpW4FYd67xpf
         yjBk08ECdViOFECvhV4OTc/ul08DMxAwH2fNEHL8K1sS5a4mMfK+HiGa3oXei14PJxRn
         stOnC39i7//82Kj+6dDyt/Vf08mR4cuTW4ky+99DSvSffIbuRMZW8gVWLz4/Q03cSayp
         y3XoA1T3nBK7rbCEnyY7uDaD9CxrRiqh8DkypJH4kUCU9TEx77ieL6rGbgLJVE9mer5/
         jjDagqj0db3gOuCKzDR4NgKi1YeCXuzN73ZU/IGEBZYcr6hW4kGMqVgW6AQ2TdxCmk4U
         pzxA==
X-Forwarded-Encrypted: i=1; AJvYcCVS16C2FnClDVYIasy+QzK1i8+Ka9UsJ5+jHqxzF1SbjU3GuA6Ov3F3yfNtM1GSZDrHTEWRTKqeSYJm@vger.kernel.org
X-Gm-Message-State: AOJu0YwEib79GPU3eV1IXgBuWVCUFUfGlHZCkmBbI+RggeJlwACmiJQC
	dJ+J3hbZh0ODkcxEgLojfL1zv8TaFSAdXjWA7piMBnJVTlaYkQpKqwEpSaFzkIZDpLVqkbh3TsF
	9vIAEOv9qSSlbyB9drO7gsi8KDCuJqJUkycHN2RWm0A==
X-Gm-Gg: ASbGncsgyq3+95Ydzjzy7fzrHhoUOXUrmGBQiZFgx+wk/tZ7jlpGTzQMtylWdO2IZsb
	8mJB25NqrlenyRKyJU8Beqy0VTv16aeGwNNv7sgKJiQRFSloPplUnIkvUfiIRw0rbpg7UZZH4IX
	+3xgTGcU0rTM5ZvrkO8QNPzaryGJ89xMYo5bKYMyv2wV1HgR/Q8N5GGTerxZGlQHooG6tpdoHc9
	nYKsA==
X-Google-Smtp-Source: AGHT+IE4c4x3lVRn3yWaa9tnU/H/1EhgcN3fcfaib4nnaW/8+GFdOShhKihsqUbzv5rnnhZHe+1YHyCZDgM6YryDE8Y=
X-Received: by 2002:a17:903:1aa5:b0:24b:11c8:2d05 with SMTP id
 d9443c01a7336-269ba542560mr64662275ad.45.1758296668243; Fri, 19 Sep 2025
 08:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-mke2fs-small-fixes-v1-2-c6ba28528af2@linaro.org>
 <17EED9B4-41D4-4D1C-9838-1ECF5B39C00D@dilger.ca> <CANp-EDZF3sVLQWdL4+a1aQLa5uqt5R_trzOp3Hh+Kw21hRn0ZQ@mail.gmail.com>
 <20250910145241.GA3662537@mit.edu> <CANp-EDZ-5_UC+p77d+ZPMMtbH3eXAPvoL4tR_EL3dcpBk-wKeQ@mail.gmail.com>
 <20250910204543.GA3659556@mit.edu> <CANp-EDagbnACsxtY5MT0yJk3tEuV=R2kapvKVNvua5azD3UyzQ@mail.gmail.com>
In-Reply-To: <CANp-EDagbnACsxtY5MT0yJk3tEuV=R2kapvKVNvua5azD3UyzQ@mail.gmail.com>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 19 Sep 2025 11:44:17 -0400
X-Gm-Features: AS18NWC10dl5j3z6UgqCUB7rSxXOGrAWUZIza9zqwVH2p6thrPnq-44Un_01xhU
Message-ID: <CANp-EDYrY0W6LE_1kc0NvhyOS65UW4znYZ_suFUQO+zxvQDA=Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] mke2fs.c: fail on multiple '-E' options
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas and Ted,

On Wed, Sep 10, 2025 at 5:31=E2=80=AFPM Ralph Siemsen <ralph.siemsen@linaro=
.org> wrote:
> On Wed, Sep 10, 2025 at 4:45=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wro=
te:
>
> > So in PRS, we need to save each of the -E arguments --- or concatenate
> > them together into a single set of extended options, and keep the call
> > site for parse_extended_options() them where it currently is located
>
> That what I am doing in patch v2:
> https://lore.kernel.org/linux-ext4/20250910-mke2fs-small-fixes-v2-2-55c98=
42494e0@linaro.org/T/#u
> It makes use of the already existing push_string() helper, to make
> copies of each argument.

Any feedback on the v2 patch series [1]? If you prefer another
approach (such as concatenating extended options) please let me know.

Also any comments regarding the other changes, particularly the
addition of root_selinux extended option?

[1] https://lore.kernel.org/linux-ext4/20250910-mke2fs-small-fixes-v2-0-55c=
9842494e0@linaro.org/

Thanks,
-Ralph

