Return-Path: <linux-ext4+bounces-12141-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F909C9F5CA
	for <lists+linux-ext4@lfdr.de>; Wed, 03 Dec 2025 15:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 94E313000B51
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Dec 2025 14:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B1E303CA3;
	Wed,  3 Dec 2025 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WM6bKsSj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1272DCF7B
	for <linux-ext4@vger.kernel.org>; Wed,  3 Dec 2025 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773590; cv=none; b=XNEv/j5A6vG7ulMz52eHpmwpxzFl8rr72oEDm1MqF+nY107NSLK3r2xM211Y4SkB+U0cejCStlbf1al1ubLG943sCoFlnJEPFND2K9+NbplbBgAVH2uHo/KqiiP6+MWgms6U8cBTkcx/r0BpuGb5guYKqMPtgw1c+Sx9SlPa/+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773590; c=relaxed/simple;
	bh=51vchZDDuCG99ZyXBOF75m/Ok9cyPANtpXmulk2ebMU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dKzRUHwPoTuiZ4ojyM43qYECPU1Cs7TKHKjve139MR4MyYb3wluqOabUdoSluQcf12JJJUzQm96NW5hkm85IwqeWnn7lPWXGIcbnSRLIjHREREQSStCY7DiMvnOt0PsK6sV8EE7k84WfyPzX4OGEwedkTP/gi+2/63GKBcDicbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WM6bKsSj; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3f13043e2fdso1260391fac.1
        for <linux-ext4@vger.kernel.org>; Wed, 03 Dec 2025 06:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764773587; x=1765378387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tc9SBGUvFCRRJRAPBShVSwTVwLl3EJakXc/nqwdiPc=;
        b=WM6bKsSjxRqS9fzQkNFqQljre1d1/U7jIbEFzdQ53xb/Ykf83vGWbz1fENNm/EM/IN
         RgtJVNluLPT1CoQf6PPlW+ZhKRIA6LYzi7R5qgbujnjkFpRoIoXiufRnUxr08Y0Z7WBG
         HBD9I7FNRf/kuR+Wyx0hMhVHcBKjlXjk2QyTwZeQHjyjezVFaYLwErac93LuwD/6n7SX
         hqfnD7RN/Jv2J16t6xyFwTsq+VVtTvM9GuppO5bfUgSZKwrLgBT+Fo+ZKFy0H+62PQeT
         3o3+RPKj92QSWZ9z0HYxk8yisd1tJ630sGzwJq7Yobv3dMsiZR6oHoa1vbG1xo61lKAc
         dpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764773587; x=1765378387;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9tc9SBGUvFCRRJRAPBShVSwTVwLl3EJakXc/nqwdiPc=;
        b=QcjqI9P1ufaKDWjLvmbrFfJ/dPLnQjFecmiA2KJfPZvIEscscKq3FSr/ou7tdM+IGS
         ngpZz46iwQyAmvYD7JH4OnBtf5golK9fVq0+xi5b16j5dLShfVsRnzJME8KP5wSWbikA
         +zzY+4z7uzmwarTX9BiaKngVSgI8HswrP24+2urlZj0uA1uuE82Bx+hWcTi/ND0Oly+b
         lrviNj3rbba9gpfGfhOhxAyBKIuxe7wpCK1JkcjNWLofpGxt/miQplUKT5rrIHVsBKRS
         dZFvCvETh40CN0dszcovCoIw4TtAtcdiocfqtV64uaTJ5Xk2Qq18x9oQqx6DUZe/nAJK
         jsqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqbTMluBoWaf8Ghq4e5YoGclmWYVZZN9j6mbJ3/0owD9yYPCE20stRAM/F/dKqJOsLxcFAuiUB/O91@vger.kernel.org
X-Gm-Message-State: AOJu0Yyub1t4ZiYz9RBJmqqvIZoIIsy7F0qDXobWoXEw1BNJg3b1ErOR
	l0q9whJGXr/Z70hIG6x2K+0PpTaMgoTumdq2ZiBrQbHmG2Vm0/BJPlo1OOu/JJMeiUw=
X-Gm-Gg: ASbGncucqdsPxWmLgggX7/x0OBnwQe0mkNKoK8Qdl0G2Ykjy6tluegdxaYyphc0OEHo
	BpQaBnk05+khAIke+dQyN0nJCZpxdls/V133VPBATZ7o0xEskZ/b20ToKRlW4Wc19Py0KlK8BV0
	HRIqfoqA1MNa6VWlbHcXgSnEZs2H/BmNfHIHZJaObhZIER6sX9Drzyr9GhMg4wqz6LsKY+i8XBV
	mR1KBgryP4jGbhZdfEd/m+imB8ImIOKSh1AL+NwR3OVNlzapfpqEnhplRReHEQ7TY+PWr7fJuww
	RjZdgT9bRDE4e1ngvfnIpEkT+DGyIV5HGDUw5gP2bMfHK34ynZXPY4jKIp9FigQMH+j+yPWguba
	dtaJYl9cO2h7ETfEE8dJH3WaOCFDk5dPZvlImh03U0CfSxXMzMPBUCs7N22NLsEFzda8Tg/Em6r
	gUjA==
X-Google-Smtp-Source: AGHT+IEmBEK6bTGKnMdujI3ujDy4UcJas/45ozXk4d/lBkl5ABzvdXswERHZW/FvxgYvWIyzTXS/0Q==
X-Received: by 2002:a05:6808:1a08:b0:450:907:b523 with SMTP id 5614622812f47-4536e3af4f8mr1301320b6e.6.1764773587425;
        Wed, 03 Dec 2025 06:53:07 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65933cc55bfsm5953139eaf.9.2025.12.03.06.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 06:53:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
 asml.silence@gmail.com, willy@infradead.org, djwong@kernel.org, 
 hch@infradead.org, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, 
 io-uring@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-block@vger.kernel.org, 
 ming.lei@redhat.com, linux-nvme@lists.infradead.org, 
 Fengnan Chang <changfengnan@bytedance.com>
In-Reply-To: <20251114092149.40116-1-changfengnan@bytedance.com>
References: <20251114092149.40116-1-changfengnan@bytedance.com>
Subject: Re: [PATCH v3 0/2] block: enable per-cpu bio cache by default
Message-Id: <176477358617.834078.6230499988908665369.b4-ty@kernel.dk>
Date: Wed, 03 Dec 2025 07:53:06 -0700
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 14 Nov 2025 17:21:47 +0800, Fengnan Chang wrote:
> For now, per-cpu bio cache was only used in the io_uring + raw block
> device, filesystem also can use this to improve performance.
> After discussion in [1], we think it's better to enable per-cpu bio cache
> by default.
> 
> v3:
> fix some build warnings.
> 
> [...]

Applied, thanks!

[1/2] block: use bio_alloc_bioset for passthru IO by default
      commit: a3ed57376382a72838c5a7bb4705bc6c8b8faf21
[2/2] block: enable per-cpu bio cache by default
      commit: de4590e1f1838345dfd5c93eda01bcff8890607f

Best regards,
-- 
Jens Axboe




