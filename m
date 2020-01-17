Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35DDC141341
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2020 22:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgAQVlF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jan 2020 16:41:05 -0500
Received: from whm03.asteroidpc.com ([204.191.218.21]:52547 "EHLO
        nathanshearer.ca" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQVlF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jan 2020 16:41:05 -0500
X-Greylist: delayed 3075 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jan 2020 16:41:04 EST
Received: from [204.191.243.35] (port=50290 helo=[172.16.1.42])
        by whm03.asteroidpc.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <mail@nathanshearer.ca>)
        id 1isYYt-00082u-Dd
        for linux-ext4@vger.kernel.org; Fri, 17 Jan 2020 13:49:47 -0700
To:     linux-ext4@vger.kernel.org
From:   Nathan Shearer <mail@nathanshearer.ca>
Subject: EXT4 Filesystem Limits
Message-ID: <6c4b5e1b-c7d4-7b77-f7f1-f320163b1045@nathanshearer.ca>
Date:   Fri, 17 Jan 2020 13:49:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - whm03.asteroidpc.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - nathanshearer.ca
X-Get-Message-Sender-Via: whm03.asteroidpc.com: authenticated_id: mail@nathanshearer.ca
X-Authenticated-Sender: whm03.asteroidpc.com: mail@nathanshearer.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Many years ago (about 1 or 2 years after ext4 was considered stable) I 
needed to perform data recovery on a 16TB volume so I attempted to 
create an raw image. I couldn't complete that process with EXT4 because 
of the 16TB file size limit back then. I had to use XFS instead.

Also many years ago I had a dataset on a 16TB raid 6 array that 
consisted of 10 years of daily backups, hardlinked to save space. I ran 
into the 65000 hardlinks per file limit. Without hardlinks the dataset 
would grow to over 400TB. This was about 10 years ago. I was forced to 
use btrfs instead. I regret using btrfs because it is very unstable. So 
I had to choose between XFS and ZFS.

Today, the largest single rotation hard drive you can buy is actually 
16TB, and they are beginning to sample 18TB and 20TB disks. It is not 
uncommon to have 10s of TB in a single volume, and single files are 
starting to get quite large now.

I would like to request increasing some (all?) of the limits in EXT4 
such that they use 64-bit integers at minimum. Yes, I understand it 
might slow down, but I would prefer a usable slow filesystem over one 
that simply can't store the data and is therefore useless. It's not like 
the algorithmic complexity for basic filesystem operations is going up 
exponentially by doubling the number of bits for hardlinks or address space.

Call it EXT5 if you have too, but please consider removing all these 
arbitrary limits. There are real world instances where I need to do it. 
And it needs to work -- even if it is slow. I very much prefer slow and 
stable over fast and incomplete/broken.

Thanks for taking the time to consider my request.

