Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49399D388
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 17:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbfHZP5y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Aug 2019 11:57:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47819 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727864AbfHZP5y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Aug 2019 11:57:54 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7QFvSxI008412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 11:57:29 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 22FD042049E; Mon, 26 Aug 2019 11:57:28 -0400 (EDT)
Date:   Mon, 26 Aug 2019 11:57:28 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guo <guoyang2@huawei.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH] ext4: change the type of ext4 cache stats to
 percpu_counter to improve performance
Message-ID: <20190826155728.GE4918@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guo <guoyang2@huawei.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
References: <1566528454-13725-1-git-send-email-zhangshaokun@hisilicon.com>
 <20190825032524.GD5163@mit.edu>
 <20190825172803.GA9505@sol.localdomain>
 <20190826004744.GA27472@mit.edu>
 <f0495aa7-8f21-e938-9617-07ac8741acb7@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0495aa7-8f21-e938-9617-07ac8741acb7@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 26, 2019 at 04:24:20PM +0800, Shaokun Zhang wrote:
> > The other problem with this patch is that it initializes
> > es_stats_cache_hits and es_stats_cache_miesses too late.  They will
> > get used when the journal inode is loaded.  This is mostly harmless,
> 
> I have checked it again, @es_stats_cache_hits and @es_stats_cache_miesses
> have been initialized before the journal inode is loaded, Maybe I miss
> something else?

No, sorry, that was my mistake.  I misread things when I was looking
over your patch last night.

Please resubmit your patch once you've fixed things up and tested it.

I would recommend that you at least try running your patch using the
kvm-xfstests's smoke test[1] before submitting them.  It will save you
and me time.

[1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

Thanks,

					- Ted
					
