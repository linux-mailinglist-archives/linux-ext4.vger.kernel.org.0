Return-Path: <linux-ext4+bounces-7766-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF38BAAFEFE
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 17:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2911188E1E8
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 15:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512E927A10F;
	Thu,  8 May 2025 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR8bH1mA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEA3279329
	for <linux-ext4@vger.kernel.org>; Thu,  8 May 2025 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717293; cv=none; b=hCQHYmSwDSPEOcs653ZX3SDA5CgJpTSPLqzqN+SouseephDTqGJGmK+wHIe0dteYR1v3g8tOavmnx0TP4oMJb9KtvCPRPs/RN+J+/MKDRKE74RhbJ7ju5o1vFOyev4fBv3rsV2rWKAbOmA8m/Q3KpSRAouXD6I/JlyJEcmDm3YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717293; c=relaxed/simple;
	bh=LhMnBzwPWTMzVGWKVXI/SDoYRs9BSdFlQNbjEigWsX4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=CDLuL6tYdjHPfNf6/XYvbopUQ6ZsWaYZx6tRkWZ/mvPoGYMAN8/d1TCcWPgvQR5EpvDU7KVYu19kOZ04Jce94egYdQyMscOs5qCPgXJTODV5zepk8E07vBJpCGi09SfcFvk05x51L5yogmqooiNLE7BnHXY6XufLPloDC89V0Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lR8bH1mA; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so1166913b3a.0
        for <linux-ext4@vger.kernel.org>; Thu, 08 May 2025 08:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746717290; x=1747322090; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CXZQEKwczpelQ7BIL45A5fhkR4oI7EtukbpLfjvZXIk=;
        b=lR8bH1mAIra1oClheYM7bRvaKA+EPEaQdakqjfKzbWfHoGwOxDo+kydoIZOskYEVVO
         Ry8FKi0zv5QU22IT1RPbM+LxHdl/sCfwMhr9Bc7Fai7A7kRYVxRwxQKEGMRkyjzASi+s
         CsBGrcPiDHunMp6rrqGl1T4wJ23MT6b8cRtDe1JTw4RLJdslaZRYyRcHBzu80JPJLpTW
         oI0LoLlHDgVJVJRHItv0NcxBNkeWXSGRJ6zwbHP/fi8mVLkNVXvLKkF6wNtTVjuTUEtX
         /6h4eCPonLSiJXdNrKlmtLfpTTk7Ea3CVEHCftAwOFi5d/vqt99Bb7hbhyjAys4/IqCE
         niJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746717290; x=1747322090;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXZQEKwczpelQ7BIL45A5fhkR4oI7EtukbpLfjvZXIk=;
        b=P0oE9cAr4CvWpjmL8apZYu/uUcGtfQr0ROVc8y5bTb/vQ5DevV02mK0Zbug3Y5C4aZ
         XWjL1ax8440fTeYlWx9t3ezRoYMzErRCX07M5K4hCLCKLOvwNeK4uaFmtCeuDdv2K8l7
         tf9ywIS7Mbv84TJyV2B+0gBV/PKu/G0SubuCP3zLJPGOgB40z5h0O9mbtLQD6vWSaYlJ
         SOBaiJxgSY2r4WP2oRz59xyMd6duuofUcv6t2xMefQrhQChJBAmgg0RGZCDOWxCXPvKX
         eRX4FrVNBZKUGXQGub7uY+kPkwjgzl1ADOJJRqD83I7li53uZ8LWTJmP7lYPVdNG3ZcL
         8DXg==
X-Forwarded-Encrypted: i=1; AJvYcCVOUc+J2xFfT+w74xBXuILMnmt5ajYFtySCzNNbCHWkn36eKHt9PvN8wkHFJVn3fV2i9OwqLpnStKB9@vger.kernel.org
X-Gm-Message-State: AOJu0YyUSQMk+I+amUHJ6chRutCOWzRaHQlfFv9T9zKOZdZ8BodwAq8Y
	VDuP2Y2gmCk76P2bpu+5l5Mq0hAizu/irE+egEoVGnK8WhD2LOW773q0BA==
X-Gm-Gg: ASbGncsLiBFJhNK2/lR+b7xBxQ9UUOXWvcljr7FxVj8Q85qyalKBoKrpq226fiRJJWW
	AuK7HFDJpEv78eRVfsc+uey+JEyaBNQixN7Pcph+w+Aup7Uh0BAaVBmcNKZ4QTl8qL9Z3zEC0Y+
	w2b6hRAxoEUqvqleoIP2zlKjq7MnBSHp28ENNzfsdSJZZNfXq0+JtGDoWEdrhUB2oeUkE12M0x5
	5P5hR2DBWm4SGkmOlCJHYrxBPKSmdi81xVgaxAH50UMEnsb8t+F5eibVLN/ivY2xWyfvJkeOf+G
	EfoDP03+iPjHEZv9+EcbF5pARRrsV0+dc+0jBTQ1agFY
X-Google-Smtp-Source: AGHT+IHBn1q7CO8swYxy+lg6Wf33BNe0g2i8lHMI/lFc3KCPkp+ZLAqkpSQEKSTWwBeQmId4kSuBDg==
X-Received: by 2002:a05:6a00:ac86:b0:736:32d2:aa8e with SMTP id d2e1a72fcca58-7409cef5bd4mr10961425b3a.6.1746717289724;
        Thu, 08 May 2025 08:14:49 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237736d51sm111235b3a.65.2025.05.08.08.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 08:14:49 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc: djwong@kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org
Subject: Re: [RFC v2 0/2] ext4: Add multi-fsblock atomic write support using bigalloc
In-Reply-To: <d031d255-b528-4870-b933-475b969aabdf@oracle.com>
Date: Thu, 08 May 2025 20:05:27 +0530
Message-ID: <878qn7gogg.fsf@gmail.com>
References: <cover.1745987268.git.ritesh.list@gmail.com> <d031d255-b528-4870-b933-475b969aabdf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 30/04/2025 06:20, Ritesh Harjani (IBM) wrote:
>> This is still an early preview (RFC v2) of multi-fsblock atomic write. Since the
>> core design of the feature looks ready, wanted to post this for some early
>> feedback. We will break this into more smaller and meaningful patches in later
>> revision. However to simplify the review of the core design changes, this
>> version is limited to just two patches. Individual patches might have more
>> details in the commit msg.
>> 
>> Note: This overall needs more careful review (other than the core design) which
>> I will be doing in parallel. However it would be helpful if one can provide any
>> feedback on the core design changes. Specially around ext4_iomap_alloc()
>> changes, ->end_io() changes and a new get block flag
>> EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS.
>
> I gave this a try and it looks ok, specifically atomic writing mixed 
> mappings.
>

Thanks John for taking a look.

> I'll try to look closer that the implementation details.

We are in the process of sending v3 (hopefully by tonight) which is an
improved version w.r.t error handling, journal credits and few other
changes. Although nothing has changed w.r.t the design aspect.

> But I do note 
> that you use blkdev_issue_zeroout() to pre-zero any unwritten range 
> which is being atomically written.

Yes, that is how internally ext4_map_blocks() with
EXT4_GET_BLOCKS_CREATE_ZERO will return us the allocated blocks. During
block allocation, on mixed mapping range, we ensure that the entire range
becomes a contiguous mapped extent before starting any data writes.
That means calling ext4_map_blocks() in a loop with
EXT4_GET_BLOCKS_CREATE_ZERO, so that it can zero out any unwritten
extents in the requested region.
I assume writing over a mixed mapping region is not a performance
critical path. 

Do you forsee any problems with the approach (since you said "But I do note...")?

-ritesh

