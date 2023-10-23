Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D71C7D27BC
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Oct 2023 02:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjJWAzw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Oct 2023 20:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjJWAzv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 22 Oct 2023 20:55:51 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133E2B7
        for <linux-ext4@vger.kernel.org>; Sun, 22 Oct 2023 17:55:48 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 39N0tUrG027576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Oct 2023 20:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1698022532; bh=f+wjiy84HCg2u0espIbpZnSTYmmEmGm8HjpTfiuYtvI=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=nc+FdK25C5hrOc6JwLCwICdGHuWAKRaF1IhgHWoiThpVUqqB6UoZSIqUkrfge8oMP
         4IgNP9qakMtQjv8TNMU4KtseNIAtz31S160hfFJJkWw97CQFdHDmEXfZ65r1EF9fzd
         gbQMfhndcvpejMy7aR50w+R6+S5KBxcbFPpmGwRbooNtIHu8MxPO647BKWle9BNAsl
         ciiG52sPxdwtPRBWJqQcklCrWxbx1KUVBeuh6upnoWrg6plVm/ZsgnfuqSW2GCOeNs
         fTQBPSp/NvWioVz/Ul/ylqd5Ez8lAth7ZpHOtt1ATfiNUtcylAXwx2ggIo8gVGELID
         r4onIotiXoZsQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8781315C0247; Sun, 22 Oct 2023 20:55:30 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Dave Chinner <david@fromorbit.com>, stable@vger.kernel.org,
        Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH v3] ext4: Properly sync file size update after O_SYNC direct IO
Date:   Sun, 22 Oct 2023 20:55:29 -0400
Message-Id: <169802252287.2300216.15136208439429495793.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231013121350.26872-1-jack@suse.cz>
References: <20231013121350.26872-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Fri, 13 Oct 2023 14:13:50 +0200, Jan Kara wrote:
> Gao Xiang has reported that on ext4 O_SYNC direct IO does not properly
> sync file size update and thus if we crash at unfortunate moment, the
> file can have smaller size although O_SYNC IO has reported successful
> completion. The problem happens because update of on-disk inode size is
> handled in ext4_dio_write_iter() *after* iomap_dio_rw() (and thus
> dio_complete() in particular) has returned and generic_file_sync() gets
> called by dio_complete(). Fix the problem by handling on-disk inode size
> update directly in our ->end_io completion handler.
> 
> [...]

Applied, thanks!

[1/1] ext4: Properly sync file size update after O_SYNC direct IO
      commit: c388da1dad59dc24801b61bc63539cab6cd83e23

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
