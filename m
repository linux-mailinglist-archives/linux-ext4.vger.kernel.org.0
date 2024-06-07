Return-Path: <linux-ext4+bounces-2831-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8019E900A3A
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jun 2024 18:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F48E285D22
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jun 2024 16:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFD719A2BE;
	Fri,  7 Jun 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0QPMp2u"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25396199EAD
	for <linux-ext4@vger.kernel.org>; Fri,  7 Jun 2024 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777517; cv=none; b=mZTPrv8qkQh5m/XKWB/SpDt13khhZn4bxmjGoYZoLnd7M8XGt2BULlNnPrC8qEOvjcWONvzeXNgjNvvP+UWgLyp2svKCbZ54MiAGJYMwsHcQO3l8cZEdJHBRFe9Ww1ShZdsvALAs9NSZC1NitHAmVxzDUAdZQIMEy2V0qwc2flQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777517; c=relaxed/simple;
	bh=OTJ1PfM+Tnwsxo6voysmL6mzNruF9Oa3wXuxZACFhWI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XboC5qxHPM/XocUeN/Hwbh9VCiyI2Wbi1zejI/u3o4azaf3kWIHumQTse6ZuLBKWvLGKEcarMjuj4AGoa6Fk9CJI1LXjmZXoGbU0oiD7Ue1jM4T00XsdzSxLDQfDlQ1pC67CUj2m8HSNTSFkpveW4vzYrjw607AMrVzaW5ERe2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0QPMp2u; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6269885572so606747566b.1
        for <linux-ext4@vger.kernel.org>; Fri, 07 Jun 2024 09:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717777514; x=1718382314; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OTJ1PfM+Tnwsxo6voysmL6mzNruF9Oa3wXuxZACFhWI=;
        b=C0QPMp2ui9+9BpIKFesmRYzi+t1ePNKi0V+JcQuSiLE53exAZABea2o0686dQ9UzZW
         fan00QPuv8vPAcdn4JpZT1DyqTt+aAz0py0WA4sXNav91jfJftojIGA2fYbxKXg4eItU
         kPxd+8RcxgOCWY7lIlbrN+vgMtdzmZZYVA2ZcFfRw4Uf6PyT/BbLvIxNTTdPkJn9yZ6d
         3/Hf5CSst1VH8FptsOb1gfM+2KGsbXpowXtCIw2IY1srHjGZeF+Xwuins60YE3bPRLAD
         ymheH7wPBEWwHLzaTtItLIfHRIcnUeB2UgUUSl4ZtJDxcv+njyedLysOrWp9knJiKzPJ
         KciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717777514; x=1718382314;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OTJ1PfM+Tnwsxo6voysmL6mzNruF9Oa3wXuxZACFhWI=;
        b=JSM3Y+jO08IFchuvrn/lW7ekr1/sJLbl5U1aoiANHonJcORBgZtSOUMJbYvfh0+DcM
         JCsDUwGCxhQuCBeAb0OvWpC77gANvv8hX0b2x4WF8mMKQOhMDJLXKhLsrY9WYxGrq9KI
         72Q/mNFbep6xAVSCAjz3DrY+2lJevzqBcbn73MxOAmS0aoRjlM6WwDvQFVu2f1SWv1Bp
         2Q/hBmV77viIgBOnIwfcg+hk92efWTR71cs51x3vI6cWnE2P6SlMaQppA/qFP0nz5kkp
         hdt6uVTWtyKF+YZv5kRuofFnRrjyv4chYdIH8LRcGNBSPEdbf8dpCkiZbTmAeUKhMeHl
         CMbA==
X-Gm-Message-State: AOJu0YwZ5T3qmWK7o9vbSaJCEm09R+QgPB6Id654BjVtk4GguXCS9iX+
	pck4rGDxPjkRJ+i4x7nOzoAX0gQQU/H9CVYbYUJrg3bW+tpvC7e8OS3yu+fZ0TIOIukLjLh17x6
	bsddGLhFlKXeo6tOAmzzsT8ZW9M3JfoEWFTbY1g==
X-Google-Smtp-Source: AGHT+IH+JzFbGTB/W7zaSg9W4PszvSXHiotG2srtCv7kngvoNOS5wx5ug6XRLH8optgJqfRBnwMpHszs3uvtrR5dcMM=
X-Received: by 2002:a17:906:4090:b0:a6e:c5c0:ba42 with SMTP id
 a640c23a62f3a-a6ec5c0bb34mr123287666b.30.1717777513781; Fri, 07 Jun 2024
 09:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nic Bretz <bretznic@gmail.com>
Date: Fri, 7 Jun 2024 09:25:02 -0700
Message-ID: <CAPXz4EPz+JVCBJ8AF3u9JKzQZk1JWZvf4oW9VVJxVTry8rJz6A@mail.gmail.com>
Subject: stat Size and Blocks numbers don't decrease after deletion
To: linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When I create a new directory and new files in it, I see its size and
blocks increase when running stat. After deleting all files, the size
and blocks of the directory don't decrease in stat.

I was thinking that ext4 runs defragmentation in the background and
eventually those two numbers will decrease. It looks like they don't.

Is this the intended behavior? Thanks
Nic

