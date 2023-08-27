Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15109789FF7
	for <lists+linux-ext4@lfdr.de>; Sun, 27 Aug 2023 17:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjH0P3S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 27 Aug 2023 11:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjH0P2v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 27 Aug 2023 11:28:51 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF8CEC
        for <linux-ext4@vger.kernel.org>; Sun, 27 Aug 2023 08:28:49 -0700 (PDT)
Received: from letrec.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37RFRp8k009067
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Aug 2023 11:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1693150076; bh=Pm51TImySKF9TxwbcWFK0CDibPV/z2o26+h2hlm1fac=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=I6AxpnUDJ1gZXxfJRpxM76cTteyn072xR/407tnUWqeS0FR3Ic4spIx9XRbqf9FFk
         1JXLqJ5vUZ1nE/4oS9RAKyR2kmcyASOUWDAqUUewpmB0nnuUZZATnOz0nyZCzHDcBn
         9GF2mcMJCvSSiD4gCudrKNXfW8T+BUfnZ8yFpN74ZIjXyTrAwFuSD1MB+MCiuRoyC6
         3YcQ3noHeYSKN996JaHF4VfC2sW4/cCM4L4Epmh7DnehPViMmxZ+nnyiMVMD3JXYyC
         p6fAP4vn10WMM8bgzqJi0US6E6pOltUqbbpugpmlRXiWaEkwT9WjCq6mEEW8eR5ofJ
         QwvvYWApIy3hA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 6F2A68C024A; Sun, 27 Aug 2023 11:27:51 -0400 (EDT)
Date:   Sun, 27 Aug 2023 11:27:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: correct error handling of ext4_get_journal_inode()
Message-ID: <ZOtrd/YVOuOuQPQF@mit.edu>
References: <20230826011029.2023140-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826011029.2023140-1-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Aug 26, 2023 at 09:10:29AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Commit '99d6c5d892bf ("ext4: ext4_get_{dev}_journal return proper error
> value")' changed ext4_get_journal_inode() to return error return value
> when something bad happened, but missed to modify the caller
> ext4_calculate_overhead(), so fix it.
> 
> Reported-by: syzbot+b3123e6d9842e526de39@syzkaller.appspotmail.com
> Fixes: 99d6c5d892bf ("ext4: ext4_get_{dev}_journal return proper error value")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Thanks, I've folded this into the commit "ext4: ext4_get_{dev}_journal
return proper error value".

						- Ted
