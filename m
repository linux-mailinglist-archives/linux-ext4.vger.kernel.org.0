Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20A92493D5
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Aug 2020 06:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgHSEYr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Aug 2020 00:24:47 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48211 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725275AbgHSEYq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Aug 2020 00:24:46 -0400
Received: from callcc.thunk.org (pool-108-49-65-20.bstnma.fios.verizon.net [108.49.65.20])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07J4OcH8019461
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 00:24:39 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9309B420DC0; Wed, 19 Aug 2020 00:24:38 -0400 (EDT)
Date:   Wed, 19 Aug 2020 00:24:38 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     adilger.kernel@dilger.ca, riteshh@linux.ibm.com, jack@suse.cz,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 2/2] ext4: limit the length of per-inode prealloc list
Message-ID: <20200819042438.GF162457@mit.edu>
References: <d7a98178-056b-6db5-6bce-4ead23f4a257@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7a98178-056b-6db5-6bce-4ead23f4a257@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 17, 2020 at 03:36:15PM +0800, brookxu wrote:
> In the scenario of writing sparse files, the per-inode prealloc list may
> be very long, resulting in high overhead for ext4_mb_use_preallocated().
> To circumvent this problem, we limit the maximum length of per-inode
> prealloc list to 512 and allow users to modify it.
> 
> After patching, we observed that the sys ratio of cpu has dropped, and
> the system throughput has increased significantly. We created a process
> to write the sparse file, and the running time of the process on the
> fixed kernel was significantly reduced, as follows:
> 
> Running time on unfixed kernel：
> [root@TENCENT64 ~]# time taskset 0x01 ./sparse /data1/sparce.dat
> real    0m2.051s
> user    0m0.008s
> sys     0m2.026s
> 
> Running time on fixed kernel：
> [root@TENCENT64 ~]# time taskset 0x01 ./sparse /data1/sparce.dat
> real    0m0.471s
> user    0m0.004s
> sys     0m0.395s

Thanks, applied with Ritesh's suggested spelling fix up.

		     	      			 - Ted
