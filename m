Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85650513707
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Apr 2022 16:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbiD1OkU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Apr 2022 10:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiD1OkT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Apr 2022 10:40:19 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919B290CCF;
        Thu, 28 Apr 2022 07:37:02 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23SEaZN2029795
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 10:36:35 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 09CAB15C3EA1; Thu, 28 Apr 2022 10:36:35 -0400 (EDT)
Date:   Thu, 28 Apr 2022 10:36:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     yebin <yebin10@huawei.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] jbd2: Fix null-ptr-deref when process reserved
 list in jbd2_journal_commit_transaction
Message-ID: <Ymqmc0VlxC1kK5BT@mit.edu>
References: <20220317142137.1821590-1-yebin10@huawei.com>
 <6268B72A.6080506@huawei.com>
 <20220427094106.5lmyockklpckkbs3@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427094106.5lmyockklpckkbs3@quack3.lan>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 27, 2022 at 11:41:06AM +0200, Jan Kara wrote:
> On Wed 27-04-22 11:23:22, yebin wrote:
> > Friendly ping...
> 
> Ted probably forgot to send his standard email but your patch is already in
> with a slightly edited message: 23e3d7f7061f86 ("jbd2: fix a potential race
> while discarding reserved buffers after an abort")

Yes, sorry, I had forgotten to send an ack for this patch.

     	      	  	       	       - Ted
