Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2384F0FDE
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Apr 2022 09:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbiDDHQH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Apr 2022 03:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbiDDHQG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Apr 2022 03:16:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2C91E3E2;
        Mon,  4 Apr 2022 00:14:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 07D5C1F37F;
        Mon,  4 Apr 2022 07:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649056447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W4k5k49pn+jL7/s0YiA95ndPbw9oktYc8ZpE4raQd2U=;
        b=1LMyelwokyDxy5bvNUE/xU1LoGr8+/eGLCsfm031j3/5cp+XcSIcGX34uIkR6ie17yNh+7
        HVTC90JrMRaf3uaBYKQaKIhm4R+ASEjmJBgc7r/PNRtfbNDA3DrVXX+tqT+1c73ZfxQHp6
        cn+XFeW2aA23Z4w7I05QA8QZ9vzp1Vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649056447;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W4k5k49pn+jL7/s0YiA95ndPbw9oktYc8ZpE4raQd2U=;
        b=qCAM3tp3Jt0t7bBgxxC+Ax2I9PCFioLUW6iedsCg6hxfFmlfG93Uya+WvZtKfkdoXFenYx
        CH5DASZ1NgFkVACg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CE3B6A3B89;
        Mon,  4 Apr 2022 07:14:06 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8F906A06B2; Mon,  4 Apr 2022 09:14:05 +0200 (CEST)
Date:   Mon, 4 Apr 2022 09:14:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Haowen Bai <baihaowen@meizu.com>, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: ext2: Fix duplicate included linux/dax.h
Message-ID: <20220404071405.m5ryafz2ifyg72xs@quack3.lan>
References: <1648008123-32485-1-git-send-email-baihaowen@meizu.com>
 <20220323113351.sibsrr3qbpuegfm4@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323113351.sibsrr3qbpuegfm4@riteshh-domain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 23-03-22 17:03:51, Ritesh Harjani wrote:
> On 22/03/23 12:02PM, Haowen Bai wrote:
> > Clean up the following includecheck warning:
> >
> > fs/ext2/inode.c: linux/dax.h is included more than once.
> >
> 
> 
> Checked "make includecheck"
> This is the only warning coming from fs/ext2/
> 
> Thanks for the cleanup. Looks good to me.
> Feel free to add -
> 
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> 

Thanks. I've added the patch to my tree.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
