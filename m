Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94C057E2C5
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbiGVN7o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 09:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbiGVN7S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 09:59:18 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CC2951FA;
        Fri, 22 Jul 2022 06:58:55 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26MDwRTk016698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 09:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658498310; bh=4+vO+WIfQKGSK9kCqxVpJgJwhESrD6cShHZGDaMVna4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZJAWxRJmO9eUyE+fcbQ9xDgP/T2r4Dn63PqY0TAuqg0RmicWBcGdM/sI6ztxka/Ul
         54vEXcjdVkE65vruh1Jw6Hev6MwemKXqAceaidYJ22oyVkmb+EjNpF2fN3Cc7ON1V8
         9EjkI85eNoselNSvL4WzLuWhyn9UKW2yYhhCKK4s1u3Zsk4g9Ma8cpRjKWwLzS3jMl
         0kONs06opV8mxUjg2RTiL0sXThUpAxd16DH+oUCvblNL56BQVlLdHHyUtj520BSiQ7
         FbN9rDkwIGStOWTnvf9syMf9Ab4kl1vzIJjKqI3MtiqM2ZDRl6jJ9OVJqBdba/cw8s
         YZsIrdalVmuGw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 695A615C3EFE; Fri, 22 Jul 2022 09:58:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     chengzhihao1@huawei.com, lczerner@redhat.com,
        ritesh.list@gmail.com, akpm@osdl.org, shaggy@austin.ibm.com,
        jack@suse.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, yukuai3@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: Fix assertion 'jh->b_frozen_data == NULL' failure when journal aborted
Date:   Fri, 22 Jul 2022 09:58:13 -0400
Message-Id: <165849767595.303416.7829836253620190185.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220715125152.4022726-1-chengzhihao1@huawei.com>
References: <20220715125152.4022726-1-chengzhihao1@huawei.com>
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

On Fri, 15 Jul 2022 20:51:52 +0800, Zhihao Cheng wrote:
> Following process will fail assertion 'jh->b_frozen_data == NULL' in
> jbd2_journal_dirty_metadata():
> 
>                    jbd2_journal_commit_transaction
> unlink(dir/a)
>  jh->b_transaction = trans1
>  jh->b_jlist = BJ_Metadata
>                     journal->j_running_transaction = NULL
>                     trans1->t_state = T_COMMIT
> unlink(dir/b)
>  handle->h_trans = trans2
>  do_get_write_access
>   jh->b_modified = 0
>   jh->b_frozen_data = frozen_buffer
>   jh->b_next_transaction = trans2
>  jbd2_journal_dirty_metadata
>   is_handle_aborted
>    is_journal_aborted // return false
> 
> [...]

Applied, thanks!

[1/1] jbd2: Fix assertion 'jh->b_frozen_data == NULL' failure when journal aborted
      commit: 4b18734448a3ee7100c5936a7fc0f9b1f2567e07

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
