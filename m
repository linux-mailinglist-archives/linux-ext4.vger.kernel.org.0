Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C10E7803E6
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 04:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357291AbjHRCmc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Aug 2023 22:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349855AbjHRCl7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Aug 2023 22:41:59 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FE43A8B
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 19:41:56 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37I2fi98000358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 22:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692326507; bh=wcvFnkK5aWq3B2Q+mIk8ZNcuAvZ+L3tBbVrbY4B6Tmw=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=BC0kQHJMA40g1Ic4Q2RzplEU26dnJtUVYFGVjz0wZyyLeukzFpXYhCx6m6I3CHUb5
         G4PjIACs6WCU76dNUwJ+qyWzopjmp+C5lRZNfUb97nd1WHQf/MQ4f+oQXx6XYRjV4X
         UbvvGl/a012qPYtDL5mQiNS8LqJl0iWNXBys5TTTnZsplkfU16Lf7+wcjfPIeTTTrP
         e1xzJhcd6Sam2kvbqFFTLOwEAFtp2ymei00U4aNsiDzYRKgB8VDQYMa5gvqKava7qx
         n8d5jXIV20aFHDI9+G590bRJqFehXxj3sJjxe3jCZ00yvhUgAfQ61NmPBfohtpyNkZ
         ZBHokxjjE5D8g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A9AE715C0501; Thu, 17 Aug 2023 22:41:44 -0400 (EDT)
Date:   Thu, 17 Aug 2023 22:41:44 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Lu, Davina" <davinalu@amazon.com>
Cc:     "Bhatnagar, Rishabh" <risbhat@amazon.com>, Jan Kara <jack@suse.cz>,
        "jack@suse.com" <jack@suse.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Park, SeongJae" <sjpark@amazon.com>
Subject: Re: Tasks stuck jbd2 for a long time
Message-ID: <20230818024144.GD3464136@mit.edu>
References: <153d081d-e738-b916-4f72-364b2c1cc36a@amazon.com>
 <20230816022851.GH2247938@mit.edu>
 <17b6398c-859e-4ce7-b751-8688a7288b47@amazon.com>
 <20230816145310.giogco2nbzedgak2@quack3>
 <e716473e-7251-7a81-fa5e-6bf6ba34e49f@amazon.com>
 <20230816215227.jlvmqasfbc73asi4@quack3>
 <7f687907-8982-3be6-54ee-f55aae2f4692@amazon.com>
 <20230817104917.bs46doo6duo7utlm@quack3>
 <f8b8e655-7485-ef11-e151-7118b1531f16@amazon.com>
 <d82df68eb8514951a7f7acc923132796@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d82df68eb8514951a7f7acc923132796@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 18, 2023 at 01:31:35AM +0000, Lu, Davina wrote:
> 
> Looks like this is a similar issue I saw before with fio test (buffered IO with 100 threads), it is also shows "ext4-rsv-conversion" work queue takes lots CPU and make journal update every stuck.

Given the stack traces, it is very much a different problem.

> There is a patch and see if this is the same issue? this is not the
> finial patch since there may have some issue from Ted. I will
> forward that email to you in a different loop. I didn't continue on
> this patch that time since we thought is might not be the real case
> in RDS.

The patch which you've included is dangerous and can cause file system
corruption.  See my reply at [1], and your corrected patch which
addressed my concern at [2].  If folks want to try a patch, please use
the one at [2], and not the one you quoted in this thread, since it's
missing critically needed locking.

[1] https://lore.kernel.org/r/YzTMZ26AfioIbl27@mit.edu
[2] https://lore.kernel.org/r/53153bdf0cce4675b09bc2ee6483409f@amazon.com

The reason why we never pursued it is because (a) at one of our weekly
ext4 video chats, I was informed by Oleg Kiselev that the performance
issue was addressed in a different way, and (b) I'd want to reproduce
the issue on a machine under my control so I could understand what was
was going on and so we could examine the dynamics of what was
happening with and without the patch.  So I'd would have needed to
know how many CPU's what kind of storage device (HDD?, SSD?  md-raid?
etc.) was in use, in addition to the fio recipe.

Finally, I'm a bit nervous about setting the internal __WQ_ORDERED
flag with max_active > 1.  What was that all about, anyway?

     	  	       	   	    - Ted
