Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A305B189C
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 11:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiIHJZI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 05:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiIHJY4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 05:24:56 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DC140E09
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 02:24:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y136so12372595pfb.3
        for <linux-ext4@vger.kernel.org>; Thu, 08 Sep 2022 02:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=A/TIz3ys6PUOn3XeB6mFl9fPNjRNK8GCUGCZ/RPFscI=;
        b=iiMBJQ/D2X1ENu5GwEQB3QpNmkB/inOO4CF5wiuapPa2ndDvDYjw5L1qnHHEG1yVmn
         hZ8qaPPm6HbwZyCE90fRw0zMaroZJUhHAM68tDB746+i/xFwXuwwEAE8rniXbzDvaIWp
         sbIE8n7iOJ3OFCtT33zv+ESvfJmfONYpFJx5kRQUebhffwb6+9Qyrb9TJX6EGxGNTdmK
         uW+MvkV0tKGArnP9cC8os7BlGWyDsQzx/QZ3J2krtfZ9s0jC+M6qKVuiP0RbpMm1nC2b
         NeVT02Zau4ihPi1DDQVFegKelAPP5HbW53kQWC975YNX267Id1GqJT2HouVXp7Y0w4q6
         iLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=A/TIz3ys6PUOn3XeB6mFl9fPNjRNK8GCUGCZ/RPFscI=;
        b=ivsIizCtElnyPUQPgOfdqHoEgbz38TIkw3XaS/qs/CN0h8+DW9BWGUMf9LlZUA93t7
         s886Jh+IlCDfg7HdB3rGWS9DRg+mUHc6Yp9Y0nOWXgnMQ0Nu3hW6wLtlbGHkTVZeiYn/
         Ee4GmsG6VsUZthHdMqKQ+SdgZAMOaqdRmgMBCgWHcb2NzStYAgEtsZT1Uf+pXSAAw81e
         Qek8w9GEl5gNyCSkAEVD35npGe8P89oo997MOSdGtgxJhodiUbZUYoErkEt4TXrJDosm
         tPsqAUFejNVe2WHZ+8fLQtcsiTPp0AaHYOGflf4TV8Ak9VaJ0NWkcjPqF5UvPOcmElwJ
         /WdA==
X-Gm-Message-State: ACgBeo13Cx9e6hNzbS2bD+3ldcDCY0qbs9506hPm3B3bFnkyjtrgrXIc
        xUmKpkhV1nbKM2W52Mekr2Y=
X-Google-Smtp-Source: AA6agR7NnI1h6uFFy8cza1ttWKXF0Vq14+HTMIjwDWywbshiY911AjAvoapaw4oonUXljmuohWAmBQ==
X-Received: by 2002:a65:6cc4:0:b0:412:35fa:5bce with SMTP id g4-20020a656cc4000000b0041235fa5bcemr6967639pgw.466.1662629094503;
        Thu, 08 Sep 2022 02:24:54 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902710900b0016edd557412sm962859pll.201.2022.09.08.02.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 02:24:54 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:54:49 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 2/5] ext4: Avoid unnecessary spreading of allocations
 among groups
Message-ID: <20220908092449.dl5ar4wbhm5cxii2@riteshh-domain>
References: <20220906150803.375-1-jack@suse.cz>
 <20220906152920.25584-2-jack@suse.cz>
 <20220907180507.3byq5uts42e6dpkn@riteshh-domain>
 <20220908085717.2kln432koqxbz3ja@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908085717.2kln432koqxbz3ja@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/08 10:57AM, Jan Kara wrote:
> On Wed 07-09-22 23:35:07, Ritesh Harjani (IBM) wrote:
> > On 22/09/06 05:29PM, Jan Kara wrote:
> > > mb_set_largest_free_order() updates lists containing groups with largest
> > > chunk of free space of given order. The way it updates it leads to
> > > always moving the group to the tail of the list. Thus allocations
> > > looking for free space of given order effectively end up cycling through
> > > all groups (and due to initialization in last to first order). This
> > > spreads allocations among block groups which reduces performance for
> > > rotating disks or low-end flash media. Change
> > > mb_set_largest_free_order() to only update lists if the order of the
> > > largest free chunk in the group changed.
> > 
> > Nice and clear explaination. Thanks :)
> > 
> > This change also looks good to me.
> > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> Thanks for review!
> 
> > One other thought to further optimize - 
> > Will it make a difference if rather then adding the group to the tail of the list, 
> > we add that group to the head of sbi->s_mb_largest_free_orders[new_order]. 
> > 
> > This is because this group is the latest from where blocks were allocated/freed,
> > and hence the next allocation should first try from this group in order to keep 
> > the files/extents blocks close to each other? 
> > (That sometimes might help with disk firmware to avoid doing discards if the freed 
> > block can be reused?)
> > 
> > Or does goal block will always cover that case by default and we might never
> > require this? Maybe in a case of a new file within the same directory where 
> > the goal group has no free blocks, but the last group attempted should be 
> > retried first?
> 
> So I was also wondering about this somewhat. I think that goal group will
> take care of keeping file data together so head/tail insertion should not
> matter too much for one file. Maybe if the allocation comes from a
> different inode, then the head/tail insertion matters but then it is not
> certain whether the allocation is actually related and what its order is
> (depending on that we might prefer same / different group) so I've decided
> to just keep things as they are. I agree it might be interesting to
> investigate and experiment with various workloads and see whether the
> head/tail insertion makes a difference for some workload but I think it's a
> separate project.
> 

Sure. Make sense.
Thanks for still sharing your thoughts on it.

-ritesh
