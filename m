Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC7D7C59C5
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Oct 2023 19:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjJKRB3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Oct 2023 13:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjJKRB2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Oct 2023 13:01:28 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E24F8F
        for <linux-ext4@vger.kernel.org>; Wed, 11 Oct 2023 10:01:26 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-152.bstnma.fios.verizon.net [173.48.102.152])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 39BH0gc9026643
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 13:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1697043645; bh=q/lSedKb7lshx7k2rQEAeRvB6s5o1LR/9RTjMM0Pa84=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=Rc2/C7WGlgIGRQErNzCcxSMHogE9oGRHAvNB2j3dbxswtI5n+kyI7gEaZ4G3t2XYD
         vgniCaTIjxuF5Kn7l7kN/sUqVEHVEphiRz6No2c+NguixtNdFguU5pxTAVFEMmRa7L
         mozXISoF8mD2gcTwwtoeTz0QTTpMTQy1dztVf/zBgg2ojvpJ30NPfFgfDc6EY8550C
         Vm6FKhIsyR0nd2gUYgV1vJ/bziErXOw/85jjMF7e91VuNXCjdk66m8RcrcHnr/7iJ4
         FcCSVVDBDUK9Hs1TLdx1HefX/oATTG+BHWGjmGUqVFW+iTE4PM8rEmDqGvJMrxTcHh
         r5JIaMzoS4H6w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4C0C715C0255; Wed, 11 Oct 2023 13:00:42 -0400 (EDT)
Date:   Wed, 11 Oct 2023 13:00:42 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Max Kellermann <max.kellermann@ionos.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL
 support is disabled
Message-ID: <20231011170042.GA267994@mit.edu>
References: <20231009144340.418904-1-max.kellermann@ionos.com>
 <20231010131125.3uyfkqbcetfcqsve@quack3>
 <CAKPOu+-nC2bQTZYL0XTzJL6Tx4Pi1gLfNWCjU2Qz1f_5CbJc1w@mail.gmail.com>
 <20231011100541.sfn3prgtmp7hk2oj@quack3>
 <CAKPOu+_xdFALt9sgdd5w66Ab6KTqiy8+Z0Yd3Ss4+92jh8nCwg@mail.gmail.com>
 <20231011120655.ndb7bfasptjym3wl@quack3>
 <CAKPOu+-hLrrpZShHh0o6uc_KMW91suEd0_V_uzp5vMf4NM-8yw@mail.gmail.com>
 <CAKPOu+_0yjg=PrwAR8jKok8WskjdDEJOBtu3uKR_4Qtp8b7H1Q@mail.gmail.com>
 <20231011135922.4bij3ittlg4ujkd7@quack3>
 <20231011-braumeister-anrufen-62127dc64de0@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011-braumeister-anrufen-62127dc64de0@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 11, 2023 at 05:27:37PM +0200, Christian Brauner wrote:
> Aside from that, the problem had been that filesystems like nfs v4
> intentionally raised SB_POSIXACL to prevent umask stripping in the VFS.
> IOW, for them SB_POSIXACL was equivalent to "don't apply any umask".
> 
> And afaict nfs v4 has it's own thing going on how and where umasks are
> applied. However, since we now have the following commit in vfs.misc:
> 
>     fs: add a new SB_I_NOUMASK flag

To summarize, just to make sure I understand where we're going.  Since
normally (excepting unusual cases like NFS), it's fine to strip the
umask bits twice (once in the VFS, and once in the file system, for
those file systems that are doing it), once we have SB_I_NOUMASK and
NFS starts using it, then the VFS can just unconditionally strip the
umask bits, and then we can gradually clean up the file system umask
handling (which would then be harmlessly duplicative).

Did I get this right?

					- Ted
