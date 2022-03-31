Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87C24EDC1C
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Mar 2022 16:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbiCaOxi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Mar 2022 10:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbiCaOxi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Mar 2022 10:53:38 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DCC210479;
        Thu, 31 Mar 2022 07:51:50 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22VEpW6V018637
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 10:51:32 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EB34815C003E; Thu, 31 Mar 2022 10:51:31 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz,
        linux-kernel@vger.kernel.org, lczerner@redhat.com
Subject: Re: [PATCH -next v2] ext4: Fix symlink file size not match to file content
Date:   Thu, 31 Mar 2022 10:51:30 -0400
Message-Id: <164873827999.891224.7471542022913117809.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220321144438.201685-1-yebin10@huawei.com>
References: <20220321144438.201685-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 21 Mar 2022 22:44:38 +0800, Ye Bin wrote:
> We got issue as follows:
> [home]# fsck.ext4  -fn  ram0yb
> e2fsck 1.45.6 (20-Mar-2020)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Symlink /p3/d14/d1a/l3d (inode #3494) is invalid.
> Clear? no
> Entry 'l3d' in /p3/d14/d1a (3383) has an incorrect filetype (was 7, should be 0).
> Fix? no
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix symlink file size not match to file content
      commit: 0f0b8dbeb99a74259062597fd669208e3500792c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
