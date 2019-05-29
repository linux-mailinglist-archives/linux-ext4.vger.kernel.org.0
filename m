Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9452DB02
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2019 12:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfE2KsQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 May 2019 06:48:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54072 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2KsQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 May 2019 06:48:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4D54B6029B; Wed, 29 May 2019 10:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559126895;
        bh=6bXZVvgn3zZXvqjSalnGG/hamaNsg3j8BVgfyjtCk4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JBVN1EabTRlGNGrK4oVniiom1LFTnKpRsX7osMzZQD8tJGcBbDQAn63AYKbL/Tw5f
         GxgtdUgSXKmuw6JoMZLBCTZA65dM4PRWkc3iKcmFS6KsQmZnn/aM3SdWQuinIWFj4+
         5cNquC7YCC9Yc2GPyPlyyNOdEyBmlkCQasnKb9M0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,LOTS_OF_MONEY,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0937F60213;
        Wed, 29 May 2019 10:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559126894;
        bh=6bXZVvgn3zZXvqjSalnGG/hamaNsg3j8BVgfyjtCk4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nBqxseulf5ASuurkKwNkDiYrPR+PNHRLTYoScrLUOZKfcfp50lVzb/gC4UuWXmxR3
         40IdIzxKA0AHz4v4F2e6/LYXl/teA8WFkpMNZv/DGIh7942ovEifZXKYHbPNMjYxHk
         by6icDRqvVR5qSbTnMeYaGTegD4Cv+h8vad8lFL0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0937F60213
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Wed, 29 May 2019 16:18:09 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, stummala@codeaurora.org
Subject: Re: fsync_mode mount option for ext4
Message-ID: <20190529104809.GJ10043@codeaurora.org>
References: <20190528032257.GF10043@codeaurora.org>
 <20190528034007.GA19149@mit.edu>
 <20190528034830.GH10043@codeaurora.org>
 <20190528131356.GB19149@mit.edu>
 <20190529040757.GI10043@codeaurora.org>
 <20190529052332.GB6210@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529052332.GB6210@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

On Wed, May 29, 2019 at 01:23:32AM -0400, Theodore Ts'o wrote:
> On Wed, May 29, 2019 at 09:37:58AM +0530, Sahitya Tummala wrote:
> > 
> > Here is what I think on these mount options. Please correct me if my
> > understanding is wrong.
> > 
> > The nobarrier mount option poses risk even if there is a battery
> > protection against sudden power down, as it doesn't guarantee the ordering
> > of important data such as journal writes on the disk. On the storage
> > devices with internal cache, if the cache flush policy is out-of-order,
> > then the places where FS is trying to enforce barriers will be at risk,
> > causing FS to be inconsistent.
> 
> If you have protection against sudden shutdown, then nobarrier is
> perfectly safe --- which is to say, if it is guaranteed that any
> writes sent to device will be persisted after a crash, then nobarrier
> is perfectly safe.  So for example, if you are using ext4 connected to
> a million dollar EMC Storage Array, which has battery backup, using
> nobarrier is perfectly safe.
> 
> That's because we still send writes to the device in an appropriate
> order in nobarrier mode --- in particular, we send the journal updates
> to the device in order.  The cache flush policy on the HDD is
> out-of-order, but so long as they all make it out to persistant store
> in the end, it'll be fine.
> 
Got it.

> > But whereas with fsync_mode=nobarrier, FS is not trying to enforce
> > any ordering of data on the disk except to ensure the data is flushed
> > from the internal cache to non-volatile memory. Thus, I see this
> > fsync_mode=nobarrier is much better than a general nobarrier. And it
> > provides better performance too as with nobarrier but without
> > compromising much on FS consistency.
> 
> "without compomising much on FS consistency" doesn't have any meaning.
> If you care about FS consistency, and you don't have power fail
> protection, then at least for ext4, you *must* send a CACHE FLUSH
> after any time that you modify any file system metadata block --- and
> that's true for 99% of all fsync(2)'s.
> 
> I suppose you could do something where if there are times when no
> metadata updates are necessary, but just data block writes, the CACHE
> FLUSH could be suppressed.  But (a) this won't actually provide much
> performance improvements for the vast majority of workloads,
> especially on an Android system, and (b) you're making a value
> judgement that FS consistency is more important than application data
> consistency.
> 
> 
> You didn't answer my question directly --- exactly what is your goal
> that you are trying to achieve, and what assumptions you are willing
> to make?  If you have power fail protection (this might require making
> some adjustments to the EC), then you can use nobarrier and just not
> worry about it.
> 
> If you don't have power fail protection, and you care about FS
> consistency, then you pretty much have to leave the CACHE FLUSH
> commands in.
> 
> If the problem is that some applications are fsync-happy, then I'd
> suggest fixing the applications.  Or if you really don't care about
> the applications working correctly or users suffering application data
> loss after a crash, you could hack in a mode, so that for non-root
> users, or maybe certain specific users, fsync is turned into a no-op,
> or a background, asynchronous (non-integrity) writeback.
> 
> Are you trying to hit some benchmark target?  I'm really confused why
> you would want to be so cavalier with application data safety.
> 
Yes, benchmarks for random write/fsync show huge improvement.
For ex, without issuing flush in the ext4 fsync() the
random write score improves from 13MB/s to 62MB/s on eMMC,
using Androbench.

And fsync_mode=nobarrier is enabled by default on pixel phones
where f2fs is used.

https://android.googlesource.com/device/google/crosshatch/+/e02e4813256e51bacdecb93ffd8340f6efbe68e0

We have been getting requests to evaluate the same for EXT4 and
hence, I was checking with the community on its feasibility.

Thanks,
Sahitya.
>     	       	     		      - Ted

