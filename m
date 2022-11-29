Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB8963BC37
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Nov 2022 09:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiK2Iyx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Nov 2022 03:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiK2IyN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Nov 2022 03:54:13 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BBFC76D;
        Tue, 29 Nov 2022 00:54:12 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id h33so7424932pgm.9;
        Tue, 29 Nov 2022 00:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpO9kHttOEsGZbAoig1yKNBzBhJaK+0I3/p2cAkfaZs=;
        b=LvLvBHzD8KLR9pMc7aejSFXchfNBTkbIRoKsfBok/8rA+WdFOCnVrs0D7l2dKDmqB0
         NaKTLlOnD+87r5spzGPMmNiYo367kNARd2oM665oRX22blBCJ5IyjRNH+A24F03sIMXE
         y5klMJz3G4lwctzcBWKTfAha8WJKXCYV72R1zhY2elc9zGaTalzPltYKAAyCB0KaYB+q
         EVCPJl1z6Wz3nE6gevFta7y7upsedhnzjLoZp5n587T9LjNcm106ApRtlVdBUZQ2VVb1
         uTIEj3fkLbxpV8B7kVSB2cvSZPYWp7pz9u2nJ1cnMhK/ouedTHd48xsVa+79xGLxOY//
         l8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpO9kHttOEsGZbAoig1yKNBzBhJaK+0I3/p2cAkfaZs=;
        b=Y68o0d6dzwyxD6p8kx4yC4T+cnvOnTKq1CJ1fAMlTg5U94ttd/Vynj80Al9DJEklvl
         MOglITn45YQMR9pF3L3Z0Al02JV0CqNrU0l2cySx1xDbZoVlyLmHEGW/dIYcCh/kYcTs
         cjaidcxx6N0qqJcWxjKYslAXH2RjNSy0EhS/Noi64NzCEjNnY7oyOqNuTNmWYYq6SwA3
         VvGRaZ58GFu7vASbuHjiKk2iPoFqvhNXtXmlLyDPuXVWAlRuD8y7lfsKw4SXbMcYUscL
         BDfiqiIe/AO6MhTcvLa92G6zJQxpkb8oNFEXAy7X4cT8jkH8Lg1XLDEzeN7WRrd11FzZ
         scgA==
X-Gm-Message-State: ANoB5pl0SzSJMCxJxb9rHbYKKCf4p90VtJI9aPi0bp0W/lqYmvvElBf1
        OyZWeKM18jzdidWwqVF1PJibZIkYcGM=
X-Google-Smtp-Source: AA0mqf4+L0YDUNzkXz4x19cY1soq07P9CzMg9r5Qgob/25mUshX3kNF6iOkAC9jpZ1TSNTMVhC4sDg==
X-Received: by 2002:a62:1c95:0:b0:571:baf8:8945 with SMTP id c143-20020a621c95000000b00571baf88945mr36191579pfc.83.1669712051911;
        Tue, 29 Nov 2022 00:54:11 -0800 (PST)
Received: from localhost ([129.41.58.18])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b001895d87225csm10155545plx.182.2022.11.29.00.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 00:54:11 -0800 (PST)
Date:   Tue, 29 Nov 2022 14:24:01 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        lczerner@redhat.com, enwlinux@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/2] ext4: add inode table check in __ext4_get_inode_loc
 to aovid possible infinite loop
Message-ID: <20221129085401.amqusrucv3h5ihq7@riteshh-domain>
References: <20220817132701.3015912-1-libaokun1@huawei.com>
 <20220817132701.3015912-3-libaokun1@huawei.com>
 <20220817143138.7krkxzoa3skruiyx@quack3>
 <20220818144353.q6cq3b7huwkopk5b@riteshh-domain>
 <Y4UdoyF6+oDI6w5P@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4UdoyF6+oDI6w5P@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/11/28 03:44PM, Theodore Ts'o wrote:
> On Thu, Aug 18, 2022 at 08:13:53PM +0530, Ritesh Harjani (IBM) wrote:
> > Folding a small patch to implement the simple bound check. Is this the right
> > approach?
> >
> > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > Date: Thu, 18 Aug 2022 07:53:58 -0500
> > Subject: [RFC] ext4: Add ext4_sb_getblk() wrapper for block bounds checking
> >
> > We might need more bounds checking on the block before calling sb_getblk().
> > This helper does that and if it is not valid then returns ERR_PTR(-EFSCORRUPTED)
> > Later we will need to carefully convert the callers to use ext4_sb_getblk()
> > instead of sb_getblk().
>
> Hey Ritesh,
>
> I was going through some old patches and came across this RFC patch.
> Have you had a chance to polish this up?  I don't think I've seen a
> newer version of this patch, but maybe I missed it.

Hello Ted,

Sorry, I guess I completely forgot about this, since around those dates
I was travelling. I will definitely try and get back to this once I finish
few ongoing things on my plate.

Thanks for bringing it up!

-ritesh
