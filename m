Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73401505FDD
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Apr 2022 00:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiDRWq0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Apr 2022 18:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiDRWqT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Apr 2022 18:46:19 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A472AC7F;
        Mon, 18 Apr 2022 15:43:38 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23IMhFCS005193
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 18:43:16 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5FBBF15C3EB8; Mon, 18 Apr 2022 18:43:15 -0400 (EDT)
Date:   Mon, 18 Apr 2022 18:43:15 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     =?utf-8?B?5bi45Yek5qWg?= <changfengnan@vivo.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH 2/3] f2fs: notify when device not supprt inlinecrypt
Message-ID: <Yl3pg33jbLIIig7G@mit.edu>
References: <20220418063312.63181-1-changfengnan@vivo.com>
 <20220418063312.63181-2-changfengnan@vivo.com>
 <Yl0RmUoZypbVmayj@sol.localdomain>
 <KL1PR0601MB400369725474F2A2DE647057BBF39@KL1PR0601MB4003.apcprd06.prod.outlook.com>
 <Yl3lxMnZ5teL+bkU@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl3lxMnZ5teL+bkU@sol.localdomain>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 18, 2022 at 03:27:16PM -0700, Eric Biggers wrote:
> > When I test fscrypt first, it make me confused. Not a real problem, just make this logical more reasonable.
> > Do you think this needs to be revised?
> 
> Well, I'm just not sure we should do this, or at least by itself, given that
> support for inline encryption is not an either-or thing, and the inlinecrypt
> mount option is already documented to apply only to files where inline
> encryption can be used.

Indeed; some encryption algorithms won't be available because they
weren't compiled into the kernel; others because block device for a
particular file system doesn't support inline crypto.

It seems to me that the test or the test runner should be able to
figure this out.  It should be able to explicitly try to set a
particular policy, and if that policy fails, it should give an
intelligent message, e.g., "Skipping this test config because
inline-crypto isn't supported."

Why can't we fix this in the test runner's scripts?

						- Ted
