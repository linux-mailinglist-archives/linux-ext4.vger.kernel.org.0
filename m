Return-Path: <linux-ext4+bounces-4991-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3181E9C09C5
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 16:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62CB11C22762
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 15:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484DA2144AE;
	Thu,  7 Nov 2024 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="hLW1iUDx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813F9213ED3
	for <linux-ext4@vger.kernel.org>; Thu,  7 Nov 2024 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992414; cv=none; b=OsRU9c7kYIxaZyPQeVuTG77NslbuoLXydcTZFtVoiuLtoMpAIe2HeKshd3O41T7s3MQVhrctRrHMOQuqOJL5jX33TW06hWLPsPCb9HwXE5xX+uiWirPXKoxE/Nn/LqagU648JSaMv4P9JEyh+Y5ROYOieT51gHLAnRwvcC6/Nmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992414; c=relaxed/simple;
	bh=oGnI8pY+GrGRrG1icU2LRO+UbcWIZI78QAZqO9PaSRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=foxU/Ma468qXmfvYxQu4XeppL/yFzq/Pqutwbu42j262wfAKnEA5/L5IDN25Q/0dqUfhNTNTHcvbnu+8GeFui0kraKHhrPIyBgJK7el5zQXolwBT6tnklBAnz8EQQwVX14hV/ChmsoDIXswWXw/6Cm/ikO+tvMJWf9VE3YUNcbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=hLW1iUDx; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A7FD8uY003590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 10:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730992391; bh=w/1XCbdwr9TRaRkT6Js0Wv7GL70wgyHBACNKnw8Igck=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=hLW1iUDxOIhPmOcZVocZmGvqWReJ+eZ9Wvu3+EAiNebu0jeoAVk++Pii4bV6w0wyd
	 CYB0WEXgOG8HqMML+RPIn8CxIGeXrTriMTFQYFVNK0TkLxJ5UfsY+72wfArTTTjTUY
	 8Qg0Zd21M0gLIN6kTsa6FJ5YxtHW4phgZTwr4vckqgVz73x7DQ10/JKqkBATkLLdJ5
	 bU49GTYhM8ArgQx5zliIYk2WX5vvj6ahEpgfv1KqGLcCsOriO0sNfwgnDil0NP2QBp
	 Mc52CxD74kvsTI9coSeZYYbucnyv9a2M0cBnfaqVPjVqZhwWXHFh56PLvNYCrGgYPT
	 Ps3RtZXOJnZBA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4AFA015C1942; Thu, 07 Nov 2024 10:13:06 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, R Sundar <prosunofficial@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, riteshh@linux.ibm.com,
        kernel test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH linux-next] ext4: use string choices helpers
Date: Thu,  7 Nov 2024 10:12:59 -0500
Message-ID: <173099237656.321265.16418369156766314115.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241007172006.83339-1-prosunofficial@gmail.com>
References: <20241007172006.83339-1-prosunofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 07 Oct 2024 22:50:06 +0530, R Sundar wrote:
> Use string choice helpers for better readability and to fix cocci warning
> 
> 

Applied, thanks!

[1/1] ext4: use string choices helpers
      commit: e4765b185abd8fa49709598559cedb2c0822955e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

