Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE1B6F3239
	for <lists+linux-ext4@lfdr.de>; Mon,  1 May 2023 16:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjEAOqm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 May 2023 10:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjEAOql (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 May 2023 10:46:41 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D92E9
        for <linux-ext4@vger.kernel.org>; Mon,  1 May 2023 07:46:39 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 341EkWjk009738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 May 2023 10:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682952394; bh=1hS6tpwzGBFwF1HZqIjNluK+tKVasJjPlzPNt1RRQLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=GauAwYSCr0/2MZCy8myAhxB3OYeUNr513J/F2VwN7Qo4CxmufnrkjHHwxRp6rPNI9
         ruRKMBrHJI6Vx/5+SvpkpvwE8BQiWVFnhORyIqamOsfrwVRai+/C087Ko3N5Gwu+R3
         Ih6iGIlYxUUIVqaseYrWmSgykX0cdMsMvl8JtA920jNL6C0NrOvE+xESI5VuhusFZ8
         9KGVF2udZKHuJ1hPoG1KmYSmuDcdFQCSrlnhAqZPfvhBq6gc3hoLR+tL3ICkjN95B4
         aZTXhzQfzhUBq4ukeCyFSRw00LPsF8IeGKDQEmIHQ2cDJ5RV0tL8Oz1+JGDhRqHfeX
         EzWTk/O0i7nWA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 212FB15C02E2; Mon,  1 May 2023 10:46:32 -0400 (EDT)
Date:   Mon, 1 May 2023 10:46:32 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+fa1bbda326271b8808c9@syzkaller.appspotmail.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] possible deadlock in __jbd2_log_wait_for_space
Message-ID: <20230501144632.GA599899@mit.edu>
References: <000000000000994fbe05e5b5d4d9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000994fbe05e5b5d4d9@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

#syz fix: ext4, jbd2: add an optimized bmap for the journal inode
