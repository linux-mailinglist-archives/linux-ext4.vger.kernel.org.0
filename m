Return-Path: <linux-ext4+bounces-3993-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD61965A56
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 10:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA6328D62A
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 08:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC9416DC33;
	Fri, 30 Aug 2024 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/8z+twJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA62416726E;
	Fri, 30 Aug 2024 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006624; cv=none; b=kiSMRosnDz3+DzeAk/fE2XQAD1iZUmZenn/3fc/wGZTjVtErojBOyxlioK3CiT4dv1BT/Ftl/hM1zL6NnoVCe/D77Pr25tKKuri0l44xTXpslCH0YuxQ9d+9GF+zhDrZ5dlETldj/aids6BznWVAvqr0A+5/8FzLY5aaU7lcliI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006624; c=relaxed/simple;
	bh=/dAWWQ2rfUnLrQq9TUaj1Fx1ebkqv7dCSYmP/QGJuDk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=iP/QLc2Yk9Nc2A81tqWvcbwDmdvk92pX7Z20jBH+Zcvb9b8yuyVLMmE05ZzCMRVzHbngKDH+uDL0bx38+i4tb7wP1Z0OB0rDx7Q/wCmFQTupqdLFPsdMF4q2bOyKOOCB6f3x49NE6hliatdUJNeUz9HwnuB0WbxHMOgRySkNs18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/8z+twJ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7140ff4b1e9so1323949b3a.3;
        Fri, 30 Aug 2024 01:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725006622; x=1725611422; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RRQZdX3CMtZuwTy9SAGSEIfOLAyvK8r1+K1io/zIo2o=;
        b=I/8z+twJ53NQQVyMFcTliKwknqW3wIDAjNeao7w3F7ncywgt3cfH8gfhHHWgJYgf3+
         IQJNAewEyIHxjbvu2elqgMrv1MFQ+h8JdELJLx19Ba9rVl3Sz4yF70ER4KHn4nQfZdUv
         7kl6lKSSEDQjrGsEZ2H1njpq7jBH9Ddv4Rp2MdrP706lFMHWcnpxVc5ng0a6zWJVH1Yk
         SIH/Wp9ejQUsFwfOv153K9nne7tqUrMUDKtot1fC92rTz/5BkWhnrho0R988IDqm0+DK
         49MwXfpk1MvjLIBnpKFXRLvXsW5W9C13cZGmCKWWul4Emokb4zyE+wTdTEhIYwxuaaTv
         W5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725006622; x=1725611422;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRQZdX3CMtZuwTy9SAGSEIfOLAyvK8r1+K1io/zIo2o=;
        b=Xkvk4e1ICg/CPswBM43/U7586YXyaVHgQ2PX4hxMRD0+U2b2hhvfMbFiSK7y4yvun4
         C+m9PcbwAF6LN7gBIKthiPRgXiTw1n2SqneO5ks/NOKcaDkvKddFA1xsHm2rABOTqxzC
         L5x0/0WydNUkOcxAcFyqpqbc9YkMTy+qOmSoN25/EZJ8Wwo8Hc3JL39p6t2NhPLRdMG9
         AXkSgByC9D5fPeldyB7o/5zIm7w1Q9D9y6wFAoZjCFujnnz4iH9crELRv3zbkRrEaQWb
         fNCRvBHnfpL/LTgKHNDqnrXmhekpSSkbXzKb+OSZEytHWNlq1hXh6MBIg1zHKsXRyR/g
         qb2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNHrru2UQPItgvuFl0AuCfeJrTMoalw0rWMeyBTqwzFRPcpeT/pZRCY1DjXaiuG4mQOctvk5kkCR83@vger.kernel.org
X-Gm-Message-State: AOJu0YxhINvC9lgh/cU/M8jT0cqWfuZfz7f5mOx0sFORTOzCrH8xvCEU
	R4u7XLB09Xj4XakGRbFVZhROlwQaGEofn/Mg23F9O14BuIaLdFoD
X-Google-Smtp-Source: AGHT+IEyRr3Hw4NRGFiX8qgplrPe1z0khhV9ICsdC+PRrgwuwvwL6BISgqltF7QSTC8DG5W6Nyvgpg==
X-Received: by 2002:a05:6a00:91a8:b0:714:2198:26b9 with SMTP id d2e1a72fcca58-715dfbe07a3mr5713640b3a.13.1725006621939;
        Fri, 30 Aug 2024 01:30:21 -0700 (PDT)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d771csm2266959b3a.165.2024.08.30.01.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:30:21 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, Kemeng Shi <shikemeng@huaweicloud.com>
Subject: Re: [PATCH v3 2/2] ext4: Convert EXT4_B2C(sbi->s_stripe) users to EXT4_NUM_B2C
In-Reply-To: <e0c0a3b58a40935a1361f668851d041575861411.1725002410.git.ojaswin@linux.ibm.com>
Date: Fri, 30 Aug 2024 13:58:53 +0530
Message-ID: <87bk1aza62.fsf@gmail.com>
References: <3a493bb503c3598e25dcfbed2936bb2dff3fece7.1725002410.git.ojaswin@linux.ibm.com> <e0c0a3b58a40935a1361f668851d041575861411.1725002410.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:

> Although we have checks to make sure s_stripe is a multiple of cluster
> size, in case we accidentally end up with a scenario where this is not
> the case, use EXT4_NUM_B2C() so that we don't end up with unexpected
> cases where EXT4_B2C(stripe) becomes 0.
>
> Also make the is_stripe_aligned check in regular_allocator a bit more
> robust while we are at it. This should ideally have no functional change
> unless we have a bug somewhere causing (stripe % cluster_size != 0)
>
> Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Thanks for addressing the review comment. LGTM. 
Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com> 

