Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE895F033F
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Sep 2022 05:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiI3DVJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 23:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiI3DUj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 23:20:39 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212F446842;
        Thu, 29 Sep 2022 20:20:11 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28U3JoNT002501
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 23:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664507992; bh=mvMvmVIAoOjVP5QOOMVipfeNdOJEKKXm6IJTSTS/QIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=qDcIRWXTvr+xX9xGXtAKtpwreoX1dtkJRJB655BzyZpY8Ar05MnQI6Mix+rgBdZ63
         zWn94P5DWnT8q9TD07Zr3EZzneBmsZYwyOHCfxx0MOyd15BJcYxAVY2g0QQyq1LXb8
         +0BwF+IPW+CevEmtZGwltrNbZex4OuefptszQ9zDgYwI+ua9rh7C0WBc6mI7rJYABJ
         g/EbGnintK6M8DrLJOGIxKokIkb8IAjwKhuY2NbAL+ODyXoY6qHuDNEcvBQBTvX9gU
         KbDvAC8DGzDG8CQCeTCM1w+qKjGaK8VLl9/UWyu9DKVrIwzkEAjlDBSvWaBEo+Au6R
         7wj1yCrIwnxAQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A25CB15C3707; Thu, 29 Sep 2022 23:19:47 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        yebin10@huawei.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v2 0/3] Fix two potential memory leak
Date:   Thu, 29 Sep 2022 23:19:45 -0400
Message-Id: <166450797717.256913.15506787519907913204.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220921064040.3693255-1-yebin10@huawei.com>
References: <20220921064040.3693255-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 21 Sep 2022 14:40:37 +0800, Ye Bin wrote:
> Diff v2 vs v1:
> Add new patch "ext4: update 'state->fc_regions_size' after successful memory allocation"
> 
> Ye Bin (3):
>   ext4: fix potential memory leak in ext4_fc_record_modified_inode()
>   ext4: fix potential memory leak in ext4_fc_record_regions()
>   ext4: update 'state->fc_regions_size' after successful memory
>     allocation
> 
> [...]

Applied, thanks!

[1/3] ext4: fix potential memory leak in ext4_fc_record_modified_inode()
      commit: 3edc135aaf975c6022f69c47e55f4e55981aff10
[2/3] ext4: fix potential memory leak in ext4_fc_record_regions()
      commit: 87429b6248196338ae578d51ae95f2e3094f8a50
[3/3] ext4: update 'state->fc_regions_size' after successful memory allocation
      commit: 24e597348a4676fb1e573faaea05eb9e6a4b422c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
