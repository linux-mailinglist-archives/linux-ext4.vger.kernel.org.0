Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18003671362
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jan 2023 06:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjARF4e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Jan 2023 00:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjARFyQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Jan 2023 00:54:16 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A180054138
        for <linux-ext4@vger.kernel.org>; Tue, 17 Jan 2023 21:53:40 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30I5rDNP010782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 00:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1674021195; bh=A436UApHmz0grSqAYwsNLN0MVJOFyYJc8T8oEw5Aluc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=iuWe/uSJv46QhWCIK5FYit3CBPxP0dhNpJSjMJ3JT4uNDpZTBc131WZqhLeknjVxw
         DM9E+pd1XTGr4RV1EacSLm3TK1EggoE1JK62D6yXaLnjCE9m8NVcZLAdq4E99Vf5Xk
         Qrtv0CssCwOO8shpU8zFpYk6spa4utIf7edsemF6MwR0V65a1PYiQJc0m38TaxfQwj
         iXnl6+XBf2gg3800GwgJH5A8ZMKaN+tSCPnQ39XjngZHE4fk5HRsZv/19zCkZAGVNc
         YGAc6TNXDXqRT0I9cLIZKHbxFWmBBb7fRN52ahKiKb7Qy3CKGxsq6kQ5ZpODMhNL/F
         T0bICPtUXSu4g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D41CC15C469B; Wed, 18 Jan 2023 00:53:13 -0500 (EST)
Date:   Wed, 18 Jan 2023 00:53:13 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Li Jinlin <lijinlin3@huawei.com>
Cc:     linux-ext4@vger.kernel.org,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>, linfeilong@huawei.com
Subject: Re: [PATCH] e2fsck: subtract acl blocks when setting i_file_acl to
 zero
Message-ID: <Y8eJSWwlyaVjgY/2@mit.edu>
References: <20220317172943.2426272-1-lijinlin3@huawei.com>
 <8e8f277d-6222-5f63-0dcb-a17771a0deff@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e8f277d-6222-5f63-0dcb-a17771a0deff@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch is not correct.  We don't need to create a new
ext2fs_adjust_ea_refcount4 to return the h_blocks field in the
extended attribute block, since that only thing that we support is a
single xattr block.

The real issue, as Zhiqiang Liu pointed out in [1], is that we should
not be clearing the i_file_acl block is the inode is only being
truncated, and not being unlinked.

[1] https://lore.kernel.org/all/ed518b11-3c38-1c1f-a75d-3293c91f17d4@huawei.com/

						- Ted
