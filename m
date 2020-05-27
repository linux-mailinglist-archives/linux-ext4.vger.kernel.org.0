Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8BE1E3E32
	for <lists+linux-ext4@lfdr.de>; Wed, 27 May 2020 11:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgE0J6D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 May 2020 05:58:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25609 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725822AbgE0J6C (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 27 May 2020 05:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590573481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JKhlMLe/B6ecqLXqArPD6M4EfIBBxVpXqlMN3JPR+es=;
        b=XJYYovmCcL7yh6u7T26Gu7rxpiJ47oEadPBuUy5URIq3ZDDBC54G5uEfJt1fJtPhR4J4a4
        UD8pHvc7+NRFy79Y8BRwgV+2bgtMvXKmY/kcu2/WELgx41scnnSFxWZMlZNoTV0fmJ4MAp
        U2Y4DYTj4WZ9PPD/TFoOacs+ahq3H6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-mt7u66drOhSWNOBns8J7Eg-1; Wed, 27 May 2020 05:57:59 -0400
X-MC-Unique: mt7u66drOhSWNOBns8J7Eg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09AE0EC1A3;
        Wed, 27 May 2020 09:57:58 +0000 (UTC)
Received: from work (unknown [10.40.194.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C05C19D82;
        Wed, 27 May 2020 09:57:56 +0000 (UTC)
Date:   Wed, 27 May 2020 11:57:51 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     Wang Shilong <wangshilong1991@gmail.com>,
        linux-ext4@vger.kernel.org, Wang Shilong <wshilong@ddn.com>,
        Shuichi Ihara <sihara@ddn.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH] ext4: introduce EXT4_BG_WAS_TRIMMED to optimize trim
Message-ID: <20200527095751.7vt74n7grfre6wit@work>
References: <1590565130-23773-1-git-send-email-wangshilong1991@gmail.com>
 <20200527091938.647363ekmnz7av7y@work>
 <520b260b-13e9-4c62-eaeb-c44215b14089@thelounge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <520b260b-13e9-4c62-eaeb-c44215b14089@thelounge.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 27, 2020 at 11:32:02AM +0200, Reindl Harald wrote:
> 
> 
> Am 27.05.20 um 11:19 schrieb Lukas Czerner:
> > On Wed, May 27, 2020 at 04:38:50PM +0900, Wang Shilong wrote:
> >> From: Wang Shilong <wshilong@ddn.com>
> >>
> >> Currently WAS_TRIMMED flag is not persistent, whenever filesystem was
> >> remounted, fstrim need walk all block groups again, the problem with
> >> this is FSTRIM could be slow on very large LUN SSD based filesystem.
> >>
> >> To avoid this kind of problem, we introduce a block group flag
> >> EXT4_BG_WAS_TRIMMED, the side effect of this is we need introduce
> >> extra one block group dirty write after trimming block group.
> 
> would that also fix the issue that *way too much* is trimmed all the
> time, no matter if it's a thin provisioned vmware disk or a phyiscal
> RAID10 with SSD

no, the mechanism remains the same, but the proposal is to make it
pesisten across re-mounts.

> 
> no way of 315 MB deletes within 2 hours or so on a system with just 485M
> used

The reason is that we're working on block group granularity. So if you
have almost free block group, and you free some blocks from it, the flag
gets freed and next time you run fstrim it'll trim all the free space in
the group. Then again if you free some blocks from the group, the flags
gets cleared again ...

But I don't think this is a problem at all. Certainly not worth tracking
free/trimmed extents to solve it.

> 
> [root@firewall:~]$  fstrim -av
> /boot: 0 B (0 bytes) trimmed on /dev/sda1
> /: 315.2 MiB (330522624 bytes) trimmed on /dev/sdb1

The solution is to run fstrim less often, that's the whole point of the
fstrim. If you need to run it more often, then you probably want to use
-o discard mount option.

-Lukas

> 
> [root@firewall:~]$  df
> Filesystem     Type  Size  Used Avail Use% Mounted on
> /dev/sdb1      ext4  5.8G  463M  5.4G   8% /
> /dev/sda1      ext4  485M   42M  440M   9% /boot
> 

