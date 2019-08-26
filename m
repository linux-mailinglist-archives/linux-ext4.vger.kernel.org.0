Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D282A9C6E7
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 02:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfHZAsN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Aug 2019 20:48:13 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48565 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726281AbfHZAsK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 25 Aug 2019 20:48:10 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7Q0li6E014485
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 25 Aug 2019 20:47:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A868042049E; Sun, 25 Aug 2019 20:47:44 -0400 (EDT)
Date:   Sun, 25 Aug 2019 20:47:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guo <guoyang2@huawei.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH] ext4: change the type of ext4 cache stats to
 percpu_counter to improve performance
Message-ID: <20190826004744.GA27472@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guo <guoyang2@huawei.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
References: <1566528454-13725-1-git-send-email-zhangshaokun@hisilicon.com>
 <20190825032524.GD5163@mit.edu>
 <20190825172803.GA9505@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825172803.GA9505@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Aug 25, 2019 at 10:28:03AM -0700, Eric Biggers wrote:
> This patch is causing the following.  Probably because there's no calls to
> percpu_counter_destroy() for the new counters?

Yeah, I noticed this from my test runs last night as well.  It looks
like original patch was never tested with CONFIG_HOTPLUG_CPU.

The other problem with this patch is that it initializes
es_stats_cache_hits and es_stats_cache_miesses too late.  They will
get used when the journal inode is loaded.  This is mostly harmless,
but it's also wrong.

I've dropped this patch from the ext4 git tree.

     	     	  	     	      - Ted
