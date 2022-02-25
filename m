Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A8B4C5210
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Feb 2022 00:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiBYX3M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Feb 2022 18:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiBYX3L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Feb 2022 18:29:11 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 814AF12341F
        for <linux-ext4@vger.kernel.org>; Fri, 25 Feb 2022 15:28:36 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A74AA53067E;
        Sat, 26 Feb 2022 10:28:35 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nNk0o-00GR4A-LP; Sat, 26 Feb 2022 10:28:34 +1100
Date:   Sat, 26 Feb 2022 10:28:34 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Andrew Perepechko <andrew.perepechko@hpe.com>
Subject: Re: [PATCH] ext4: truncate during setxattr leads to kernel panic
Message-ID: <20220225232834.GR3061737@dread.disaster.area>
References: <20220225110413.1663-1-artem.blagodarenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225110413.1663-1-artem.blagodarenko@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62196624
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=7-415B0cAAAA:8
        a=x6FlVVwMinsx5J1ogNAA:9 a=CjuIK1q_8ugA:10 a=rEb7KsgoP-gA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 25, 2022 at 06:04:13AM -0500, Artem Blagodarenko wrote:
> @@ -1791,7 +1821,7 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
>  	ret = 0;
>  out:
>  	iput(old_ea_inode);
> -	iput(new_ea_inode);
> +	delayed_iput(old_ea_inode, diwork);

That looks broken....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
