Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EA64CB428
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Mar 2022 02:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiCCAlT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Mar 2022 19:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiCCAlS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Mar 2022 19:41:18 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33484F9E4
        for <linux-ext4@vger.kernel.org>; Wed,  2 Mar 2022 16:40:33 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2230eKGf018837
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Mar 2022 19:40:21 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6E1D215C0038; Wed,  2 Mar 2022 19:40:20 -0500 (EST)
Date:   Wed, 2 Mar 2022 19:40:20 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] ext4: fix remount with 'abort' option
Message-ID: <YiAOdGqf7/smyQL7@mit.edu>
References: <YcSYvk5DdGjjB9q/@mit.edu>
 <20220201131345.77591-1-lczerner@redhat.com>
 <20220302094337.jv4d2vy4sldzbq6v@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302094337.jv4d2vy4sldzbq6v@work>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 02, 2022 at 10:43:37AM +0100, Lukas Czerner wrote:
> Hi Ted,
> 
> this problem is still generating warnings. Can you please take this in
> when you have time?

Oops, sorry.  I processed a bunch of patches last week, and had even
pushed them them out to ext4.git on git.kernel.org, but I had
forgotten to run "b4 ty".  (I was waiting for the regression tests to
finish, and then forgot to send out the e-mail ack's.)  I'll send
them out now.

					- Ted
