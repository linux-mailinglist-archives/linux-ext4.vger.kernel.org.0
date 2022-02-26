Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00574C534D
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Feb 2022 03:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiBZCYs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Feb 2022 21:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiBZCYs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Feb 2022 21:24:48 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B9426570;
        Fri, 25 Feb 2022 18:24:14 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 21Q2NcRB000816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 21:23:40 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EE27A15C0038; Fri, 25 Feb 2022 21:23:37 -0500 (EST)
Date:   Fri, 25 Feb 2022 21:23:37 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin10@huawei.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, jack@suse.cz, lczerner@redhat.com
Subject: Re: [PATCH -next v2] ext4:fix file system corrupted when rmdir non
 empty directory with IO error
Message-ID: <YhmPKVrVHhTeKOzl@mit.edu>
References: <20220211093527.3335518-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211093527.3335518-1-yebin10@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 11, 2022 at 05:35:27PM +0800, Ye Bin wrote:
> Now if read directory block failed, 'ext4_empty_dir' will return true, assume
> directory is empty. Obviously, it will lead to above issue.
> To solve this issue, if read directory block failed 'ext4_empty_dir' just assume
> directory isn't empty. To avoid making things worse when file system is already
> corrupted, 'ext4_empty_dir' also assume directory isn't empty.
> To distinguish the error type, return the exact error code to the caller.
>

Does the same issue exist for f2fs and ubifs?  We could solve the
specific bug much more simply by having ext4_empty_dir() return FALSE
if we aren't able to read the directory block.  Yes, it means that we
don't return as specific an error code in the case of an I/O error ---
although I believe we do syslog a warning --- but it makes for a much
simpler patch that doesn't requiring getting acked-by's from the
fscrypt, f2fs and ubifs folks.

							- Ted
