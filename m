Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421306F2B9C
	for <lists+linux-ext4@lfdr.de>; Mon,  1 May 2023 01:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjD3Xjo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Apr 2023 19:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjD3Xjn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Apr 2023 19:39:43 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA179170D
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 16:39:15 -0700 (PDT)
Received: from letrec.thunk.org ([216.250.210.3])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33UNd0CJ015022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 19:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682897950; bh=1hS6tpwzGBFwF1HZqIjNluK+tKVasJjPlzPNt1RRQLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=GHRZf3ts0UJmcSu2zr2QL2F+9ouvMYGNU0xyR1yw2DcH7CbMVnktz4jdjvD7es6eB
         QWKEQM1oz3Oi85TzR+dJH35Sq+dzNYIyCN6bZrfl5iYOirEwUXwzTDf3T8GGvNbsoa
         MxfW+h2ALPqfux+67sgXP/cQPrqFgsYuJHDDF+Xjxr+Z3MDCQR4nCFRYmH3w797VrT
         u25601zUPHLFVxywS/cqp/rwSM9mrvjOvRrvg42+hEWEpOoQbEgVFIFy2IhXj93cy8
         AzlUs0FhyDmCV8BjOB+eksE9+SNatwP+RwdtxLdUcgxcQSzNSFEdB8oqLg6UPCo7Z0
         c/B9dvUq4BsxQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 933F48C02D7; Sun, 30 Apr 2023 19:38:58 -0400 (EDT)
Date:   Sun, 30 Apr 2023 19:38:58 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+79e6bbabf3ce17357969@syzkaller.appspotmail.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
Message-ID: <ZE78EtzmnsFHxlas@mit.edu>
References: <000000000000892a3005e5b5d96c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000892a3005e5b5d96c@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

#syz fix: ext4, jbd2: add an optimized bmap for the journal inode
