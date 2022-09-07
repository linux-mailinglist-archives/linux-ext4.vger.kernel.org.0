Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469655B0C1F
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Sep 2022 20:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiIGSFh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Sep 2022 14:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiIGSFQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Sep 2022 14:05:16 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F9D6245
        for <linux-ext4@vger.kernel.org>; Wed,  7 Sep 2022 11:05:14 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id o126so6414954pfb.6
        for <linux-ext4@vger.kernel.org>; Wed, 07 Sep 2022 11:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=nnjMJtGChETQdq6vXb76Qly3RQ/HqSav2IoyWCKIMMs=;
        b=Cbh6x9RIawWTpTD7sQOz0r+NzH8QfgLkb7DZvj7TyLoIY/QW1h+QDBCVxioaLQVe2M
         YPrOLBp7BRv77aPqDiRzvRakdKEYcP1DmsQO47f9kwkvYr3n7dR4WamWYu9EqgIzjKT7
         3at66nhc4Bs++usdzqCAbBnkvuo3X1S7eq8LfnhzoVR3dlmckk7DRMMRn9ruwIeKk+/g
         MDlfVqYdDtyOuJ17+7YzpDt7IlfMMuDH0NbZcehusA4DJFtzJpOB7rY4Hnhc6NEnB+v6
         /CTBFzJtv2VoJO60p9dz5VKD66FyWue7jVMLw3GtHN42/4ZpECIr0WCkjtmOctsJQdP2
         PIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nnjMJtGChETQdq6vXb76Qly3RQ/HqSav2IoyWCKIMMs=;
        b=zLs5VLtxQqwtFKIAV3L2aPlC2BoYtUeWh9uEm9/Uk8VC8I0Wo6CEz6lq9a4+ytx6F8
         IXGGL19AEMrEGh/F2BvidE3RWg+96/YO1AA2ECiE3EYTLSala1+31ovSMw24dweOiQkJ
         kwTS0RN/dH34ZLxNahBBXMUiIPBBJOKaFmnY+FW25nk3faavEkY5MK71hQbtgpGgoRZv
         62kW9lT4/o9tFCmLpai78FQTIUrzhl15NLjKiZBMDMoUWEOYwS40Cs9oUqGOf34jD/Ci
         jhX+DtdazvVgpiRVmo08IMU5yvEuG657hl3KXBUVX+ezfOux5ikg9FlMHuJyFtMKcyPW
         F+3Q==
X-Gm-Message-State: ACgBeo0rrkQIhg7J1J7C86e9IDzWUsjqAsORQcg6BssZ694vJzcvP1cY
        qjCzn6qdCsjJhiOS6YHY1FE=
X-Google-Smtp-Source: AA6agR77AGkax29o6y3C6HCoDjSw9cpeCKmH7kzsO6CtGJb2gx16cg/sFDu8ppAVRHM01k9rySvIwA==
X-Received: by 2002:a63:1459:0:b0:411:b06f:646f with SMTP id 25-20020a631459000000b00411b06f646fmr4379149pgu.338.1662573913820;
        Wed, 07 Sep 2022 11:05:13 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id d3-20020a63ed03000000b004351358f056sm449564pgi.85.2022.09.07.11.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 11:05:13 -0700 (PDT)
Date:   Wed, 7 Sep 2022 23:35:07 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 2/5] ext4: Avoid unnecessary spreading of allocations
 among groups
Message-ID: <20220907180507.3byq5uts42e6dpkn@riteshh-domain>
References: <20220906150803.375-1-jack@suse.cz>
 <20220906152920.25584-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906152920.25584-2-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/06 05:29PM, Jan Kara wrote:
> mb_set_largest_free_order() updates lists containing groups with largest
> chunk of free space of given order. The way it updates it leads to
> always moving the group to the tail of the list. Thus allocations
> looking for free space of given order effectively end up cycling through
> all groups (and due to initialization in last to first order). This
> spreads allocations among block groups which reduces performance for
> rotating disks or low-end flash media. Change
> mb_set_largest_free_order() to only update lists if the order of the
> largest free chunk in the group changed.

Nice and clear explaination. Thanks :)

This change also looks good to me.
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


One other thought to further optimize - 
Will it make a difference if rather then adding the group to the tail of the list, 
we add that group to the head of sbi->s_mb_largest_free_orders[new_order]. 

This is because this group is the latest from where blocks were allocated/freed,
and hence the next allocation should first try from this group in order to keep 
the files/extents blocks close to each other? 
(That sometimes might help with disk firmware to avoid doing discards if the freed 
block can be reused?)

Or does goal block will always cover that case by default and we might never
require this? Maybe in a case of a new file within the same directory where 
the goal group has no free blocks, but the last group attempted should be 
retried first?

-ritesh

 
