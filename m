Return-Path: <linux-ext4+bounces-1716-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5585688158C
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Mar 2024 17:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5793E1C20F55
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Mar 2024 16:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A02854BFD;
	Wed, 20 Mar 2024 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di7w1HgN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668F642044;
	Wed, 20 Mar 2024 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951807; cv=none; b=IS9xN4JMeFHn0xSX7MK218bxtXUjAsDCFBmaK1Dlom0kxUs+EnUJm1dGq1gtiWs6eaXI84oSGRwT71PFuCxiIiynjfcMOtUYubKwebkPPgex81JkULCPJtfOqcsQkk3YyusPsQF5FiMRyrqmJ/GbXGgEf2f7l+g00fK656sJocU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951807; c=relaxed/simple;
	bh=mgzJ5FaYkrhvQaKpZV1iW6pBVT3RvVqjQJGbEGYd3qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vw5fcP5B2+D5Rgcd9jgmlR6lX9XU04/azj59agomZGW1PBKEBe19k30ieqTqu0t7EESWeO01w5nPSQlEHMg7ZB62B67JOd+R84VKx7qjQdzu1PTZNLc9Fm/9Z5FIjn78VQZFpOFfSmoKXjP3VuHcKckQAZjp3Dn7kMPQ9RuwOSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=di7w1HgN; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c390f91b22so68523b6e.0;
        Wed, 20 Mar 2024 09:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710951804; x=1711556604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7HCoj6FBfeuvSERwRVEKdrwb/Pg7vtXdaZdOdV0qAk=;
        b=di7w1HgNrCtaeBmxoo/RNpFMksk5+s9N11EOnsyIdjfszRD+xybYN8uxhFNGWoLBMw
         BgLdJlkDUfoKybPH3haIyuJQxuz3Yq8Ys+rrQcGdKL+9d1qljj6Yco8X03k4dFGU0hua
         ixj+OnI2dNGymBmYCBFOlZh/zKVeKyJvTd8GNBJkxCEi4Ivaz4DsaEV6uJ9pJjiUsgtq
         Nq5IGlJrj/Omp2WBi4JFO7j7XZFEZoXELCYmcTw9FgSDgw3G4Y0ynJIs5gkjn9mD6ggS
         A7DE9GnE7njYhmHxZxnCEt4vOXdQ+lXUWFiIiNppIrlNArxrAr2RaOV7RULkwYamJnEI
         VciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710951804; x=1711556604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7HCoj6FBfeuvSERwRVEKdrwb/Pg7vtXdaZdOdV0qAk=;
        b=tN056+Pthso3HqF4gWuYY/hbyfh83S0a4oLg+NhZm76kuOQRntL1nuAXUGjN9uG3r/
         Mai1G/NLSyp5HKAo3Z03wU0WrM/OUOq2vbi4Bo1yvk3q+lDkSQaS3DTIR7jiT4IJYjJk
         rEaDp1lRKFxcVb67/pAIVdq6ox9V/nnUO9uZwLhLbBHPK9LdLeMfEkxHQJWF+Vk5nIw4
         D0lfVVYUw9eFeTUCnsgU6TZGTL7x+roAjCLYFB7WWaoYjkM5/zFLGsnUdO7M8kZci3ln
         ZhuOC27fZmh+G4hWzCVSWvpXSDFVBWbOlNvrXsyXPk0UgAv6KBnpcYxq+M5LW0b9/znI
         sowA==
X-Forwarded-Encrypted: i=1; AJvYcCXa3PdpS9rmMc3UyFAbh0TIBjgYqhEEc/N6fGNTaQTmz5QGEeXPe7R87rleP/I84siFrdWZawvAkEXbCChIb+0GDUlwuqugI+PI3yO5BgdN+cEqZDwFxr/zkz0iGJndgOsN8lOO3Lzekg==
X-Gm-Message-State: AOJu0Yx4pGHMWgB2/gB+kZgpi+NRn+FJkE6oijvbV4sutDmdjOIoTbXn
	cipYf817/eEWTNdtCiB+8taFOxUCv2z3bxRDLw3l03CwWrjFxx0W33XekYOd
X-Google-Smtp-Source: AGHT+IFMmscs+FUX4ggpUYRNQxo5IayKC9D7xsggUTXCObaS2Z0fpW7smOzoCqb6wznemN2yyO9DXg==
X-Received: by 2002:a05:6358:726:b0:17e:b7a0:2ecd with SMTP id e38-20020a056358072600b0017eb7a02ecdmr7070587rwj.0.1710951804370;
        Wed, 20 Mar 2024 09:23:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i2-20020a632202000000b005e2b0671987sm10995523pgi.51.2024.03.20.09.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 09:23:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 20 Mar 2024 09:23:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] ext4: Add unit test of ext4_mb_generate_buddy
Message-ID: <30a8ce01-84d1-48ef-a93d-d14cc61723e3@roeck-us.net>
References: <20240103104900.464789-1-shikemeng@huaweicloud.com>
 <20240103104900.464789-3-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103104900.464789-3-shikemeng@huaweicloud.com>

Hi,

On Wed, Jan 03, 2024 at 06:48:57PM +0800, Kemeng Shi wrote:
> Add unit test of ext4_mb_generate_buddy
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

With this and other new ext4 tests test in the tree, I see a variety
of backtraces in the upstream kernel if debug options are enabled.
An example is

[    6.821447]         KTAP version 1
[    6.821769]         # Subtest: test_mb_generate_buddy
[    6.824787] =============================================================================
[    6.825568] BUG inode_cache (Tainted: G                 N): Padding overwritten. 0xfffff80006223f68-0xfffff80006223f6f @offset=16232
...
[    6.894341] ok 7 ext4_inode_test
[    6.895411] =============================================================================
[    6.895777] BUG inode_cache (Tainted: G    B            N): Padding overwritten. 0xfffff80006223f68-0xfffff80006223f6f @offset=16232

Another example, from another test run, is

[    3.938551]         # Subtest: test_new_blocks_simple
[    3.947171]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
[    3.952988]         ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
[    3.958403]         ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
[    3.958890] =============================================================================
[    3.959159] BUG inode_cache (Tainted: G                 N): Padding overwritten. 0xffff8de881adbf68-0xffff8de881adbf6f @offset=16232

Another one:

[   18.730473]         # Subtest: test_new_blocks_simple
[   18.760547]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
[   18.778477] ==================================================================
[   18.778950] BUG: KFENCE: out-of-bounds write in ext4_mb_init+0x5d7/0xa60

This is just a sample, taken from a quick look at test results.

Are those backtraces expected ? If so, would it be possible to execute the
tests without generating such backtraces ? The backtraces, if intentional,
hide real problems in the noise.

Thanks,
Guenter

