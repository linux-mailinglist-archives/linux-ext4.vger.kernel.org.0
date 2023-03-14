Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FCE6B9507
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Mar 2023 13:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCNM65 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Mar 2023 08:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjCNM6k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Mar 2023 08:58:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C257BA42F3
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 05:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3324B6173A
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 12:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98A78C4339C
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 12:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678798380;
        bh=fB6a/cWvzUoEp7Y6DPIs0LthtwkFoA1O3HkeJrH7V94=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AYyYrNGGvZvUNDlGeEkx14gYAptrQuPqCmhw2NUkrLDdbiwdxxF8Of1nXhKjAmd6M
         HhvhENF5VMhOa23aT4bT+GytcFHmSa5wzUrvYeoKVkhWiiFcXh0apWFqqB/azovU3w
         mifUUgMVQBQD6b5gvIXBNnZVY9qw/4EG+n+1dYtedwADv1A3oxWBKwQOKXseQ8PK8c
         1AnwMCbJAR0YrHQc/1gMrz9RRwMjeYXKo0gcbXJVpxT6rFg5141u6gOYyQ8cf5PgjG
         S4MSelaP27Fl8coBW4z7kXijtXUF9zSwBivByQTKvSB6ooUX0DnCDn8v+EcfRFb+y+
         mVi/g62mKcOPQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 890A0C43145; Tue, 14 Mar 2023 12:53:00 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217189] SATA HDD not detected
Date:   Tue, 14 Mar 2023 12:53:00 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: Serial ATA
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: tj@kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component assigned_to product
Message-ID: <bug-217189-13602-ew2mCzZZCg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217189-13602@https.bugzilla.kernel.org/>
References: <bug-217189-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217189

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|ext4                        |Serial ATA
           Assignee|fs_ext4@kernel-bugs.osdl.or |tj@kernel.org
                   |g                           |
            Product|File System                 |IO/Storage

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
