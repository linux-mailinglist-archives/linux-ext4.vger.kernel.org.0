Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B5C538F21
	for <lists+linux-ext4@lfdr.de>; Tue, 31 May 2022 12:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiEaKki (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 May 2022 06:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239301AbiEaKkg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 May 2022 06:40:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4379981B
        for <linux-ext4@vger.kernel.org>; Tue, 31 May 2022 03:40:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9D32B1F97B;
        Tue, 31 May 2022 10:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653993634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yPlRgILO60yHJIaTmqGLK4dzChGP+XZk9I4PGfYIESk=;
        b=BIO8HdZ1A8XcUTEl53UHgou5ySY5V7vvCpHn1yAva3EsbXYnKn2Heel/M9z2+jQOms66hZ
        +py5LNkJUT1M2biNn0hDmVjeXjLNBZ6vcBHjXPIxNjNZBOH4Gx0mEQ378raGSMlqupCh0A
        tgSuG4CcsVCt/iaSY+DiNEgHnILZjzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653993634;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yPlRgILO60yHJIaTmqGLK4dzChGP+XZk9I4PGfYIESk=;
        b=gUapx4XyhCXwy1nVx6pC057FCtwfaavA6RQSEgeZ1zzishJ5DwrWcU865/3E/KlljRey+I
        RrBQ9/c/FGfTN3BA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8A2E42C145;
        Tue, 31 May 2022 10:40:34 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3F94CA0633; Tue, 31 May 2022 12:40:34 +0200 (CEST)
Date:   Tue, 31 May 2022 12:40:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: the question about ext4 noacl mount option
Message-ID: <20220531104034.fxp62ttjpek4lbch@quack3.lan>
References: <6258F7BB.8010104@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6258F7BB.8010104@fujitsu.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Fri 15-04-22 03:41:32, xuyang2018.jy@fujitsu.com wrote:
> When I use mount option noacl on 5.18-rc2, I got the following warning
> 
> [  179.441511] EXT4-fs: Mount option "noacl" will be removed by 3.5
>                Contact linux-ext4@vger.kernel.org if you think we should
> keep it.
> 
> But now is 5.18-rc2, so ext4 do you plan to remove this option
> or keep the option util a fix version ie 5.20? Or, remove deprecated
> flag for this mount option?

Just submit a patch removing it. Thanks! :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
