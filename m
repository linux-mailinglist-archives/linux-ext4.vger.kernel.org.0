Return-Path: <linux-ext4+bounces-1718-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF2881765
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Mar 2024 19:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B9A28535A
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Mar 2024 18:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD32F85298;
	Wed, 20 Mar 2024 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0PNjJQj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A7C52F78;
	Wed, 20 Mar 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710960154; cv=none; b=K3sRIjGrU8XhSj91Ayt7S/Z0OP+1Z6WAiD7tblMSc93Up7S+VCvgVGP9VLosF3pVpo6jFtzJVuS3nLrAbsbhZrkSYJMT8RQQ4LD/qbw2bo3B3aii5JzLML1tuHhNRhdJ1sgkz28JB4fJY74uRWhGAX8w39DvRoLzwtcDqggbeyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710960154; c=relaxed/simple;
	bh=OvDWzf5QI11nP6xn7V6BvV75EVnGelLYBI+80MwL2kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1CN5GShQH3ale5KdlOxbaJqp3YAjVGX1IjXpeSnJyPtdC15oI2MJZXObxVzCcKwj+PR3Pe8LGMpG8eXLPgYfcUbpj3SZYTZykL/8xTssadX7LzhKXkdR6JdPuZk5MrLpgprRZXd7YoIyxCVl1zlWQ2pVQNrA6imeqPKYx1fMTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0PNjJQj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dddbeac9f9so583035ad.3;
        Wed, 20 Mar 2024 11:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710960152; x=1711564952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LpVGt7eapRMQ5PJBsTrUq3TIxfCzxXLVn/uEUHsdaK4=;
        b=V0PNjJQje1r4M2vkmihN3QsStJdDHpCsl9giaaDhMSHt43SaEOHyZna+HNFHPSjnsn
         jUw4yESxHcsf5y7mWHiNS7l6d8s1HxraF2exj9DkQtyN+uMqKRH6LS8AjfVqydt0m5MU
         Sp8DTGHZZ61q66HJTTkUutHROEE6DJJLPe28zAUw8yIZ0NrLKTG5JPGVTEjFJhKJktza
         /6sxLooKivKyjrKs87wo/JC5UP8OvX+NI9pshl9zoF4e9FkMCeFufEAF1A8jtPI+Td2t
         J5Hamf2oJvNmaZuiiIIy1Ix65MsiKgZUz+D0hBDQXSy+lMhCecLwrqpNhT4J+v0+oPD8
         g2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710960152; x=1711564952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LpVGt7eapRMQ5PJBsTrUq3TIxfCzxXLVn/uEUHsdaK4=;
        b=GSoD5GrM2SuBA76SsxVxBAS+/AEO9G18CaqqD7dDjhKVWZAjWFzpovyoJNM58EQ94e
         3lLJdwgW0Hx1ookWPBz0xZraP5weJQKS80uIsZGW6jQSc3NQVjIMgeEpDeZ8n3+bdCme
         leT+zrS57r7MS5lnlOebA4F4ckFPXFbh3QAsQmP57slsyr3ZxIQ5c+WRskjhhLW+IvSk
         sch1lubcVvaSLbjOlNtCmN1oDDM1BmljOFkpbgmfcf1qtan8urHnDeLvGcBohknVg3pm
         uph/DZxls/7m+iKJxmq/DhBtZsmcsUAp2vShhUs6nwAGlGny4dPd9unHNADMfEWVg1BZ
         8LYg==
X-Forwarded-Encrypted: i=1; AJvYcCXFjlhD8cc/pvJKEKeZVH/s9SH08ADP/oR/JEQXosnNkRbXGRgihm8po5ugBq/4VIxItkvdGsF2ADrksPva8CPeefPbLNP+gwgEkY2VmEduNQIfjsxbswGuSpArZRsDHIogZvBGvUqFEQ==
X-Gm-Message-State: AOJu0YxKxaUPCey1EI2xPogMbqomsB9OavGj/emTZ5feFFa7xxOPVGdJ
	Vn8dvz2jmGWlSmk5YxDpE+IYuux4jLE4vom8oPGR5w3TuTAxkBMDuNfrGTcU
X-Google-Smtp-Source: AGHT+IGAV8kfrE1TushQq2bRjeOsJwkTc6VrsiuidrOOybNSfh6ZRjlKJ0xGxxnuN3ztg9H4PEqcSA==
X-Received: by 2002:a17:903:11c3:b0:1dd:7d6a:d6c8 with SMTP id q3-20020a17090311c300b001dd7d6ad6c8mr22060937plh.14.1710960151967;
        Wed, 20 Mar 2024 11:42:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902d51000b001dd091a4224sm11466752plg.61.2024.03.20.11.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:42:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 20 Mar 2024 11:42:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel.diaz@linaro.org,
	vmartensson@google.com
Subject: Re: [PATCH v2 2/5] ext4: Add unit test of ext4_mb_generate_buddy
Message-ID: <b814135f-83cb-4e8b-8b9e-c1be8a7ac597@roeck-us.net>
References: <20240103104900.464789-1-shikemeng@huaweicloud.com>
 <20240103104900.464789-3-shikemeng@huaweicloud.com>
 <30a8ce01-84d1-48ef-a93d-d14cc61723e3@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a8ce01-84d1-48ef-a93d-d14cc61723e3@roeck-us.net>

[ Adding more interested parties]

On Wed, Mar 20, 2024 at 09:23:24AM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Wed, Jan 03, 2024 at 06:48:57PM +0800, Kemeng Shi wrote:
> > Add unit test of ext4_mb_generate_buddy
> > 
> > Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> With this and other new ext4 tests test in the tree, I see a variety
> of backtraces in the upstream kernel if debug options are enabled.
> An example is
> 
> [    6.821447]         KTAP version 1
> [    6.821769]         # Subtest: test_mb_generate_buddy
> [    6.824787] =============================================================================
> [    6.825568] BUG inode_cache (Tainted: G                 N): Padding overwritten. 0xfffff80006223f68-0xfffff80006223f6f @offset=16232
> ...
> [    6.894341] ok 7 ext4_inode_test
> [    6.895411] =============================================================================
> [    6.895777] BUG inode_cache (Tainted: G    B            N): Padding overwritten. 0xfffff80006223f68-0xfffff80006223f6f @offset=16232
> 
> Another example, from another test run, is
> 
> [    3.938551]         # Subtest: test_new_blocks_simple
> [    3.947171]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> [    3.952988]         ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> [    3.958403]         ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> [    3.958890] =============================================================================
> [    3.959159] BUG inode_cache (Tainted: G                 N): Padding overwritten. 0xffff8de881adbf68-0xffff8de881adbf6f @offset=16232
> 
> Another one:
> 
> [   18.730473]         # Subtest: test_new_blocks_simple
> [   18.760547]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> [   18.778477] ==================================================================
> [   18.778950] BUG: KFENCE: out-of-bounds write in ext4_mb_init+0x5d7/0xa60
> 
> This is just a sample, taken from a quick look at test results.
> 
> Are those backtraces expected ? If so, would it be possible to execute the
> tests without generating such backtraces ? The backtraces, if intentional,
> hide real problems in the noise.
> 
> Thanks,
> Guenter

