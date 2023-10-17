Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4795C7CC113
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Oct 2023 12:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbjJQKwZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Oct 2023 06:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbjJQKwZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Oct 2023 06:52:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9D8B0
        for <linux-ext4@vger.kernel.org>; Tue, 17 Oct 2023 03:52:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7AF4C433CB
        for <linux-ext4@vger.kernel.org>; Tue, 17 Oct 2023 10:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697539943;
        bh=CUU9kn9UdrvR7Gwgtb8fLBUlrSMuXz7DXhs4tIWy7K4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ESurEB3FHuc1zI3dM9CNPgit6tXchhZmQZcU8woOQ7j9UiRNCIwEd9NyXxUw14FZb
         HHraihvpXvyUHqVznBruZFbQ0tlLYB82Djgv8ojNFi4xEjfy/iTgEIOlxL/IyVgQeu
         Ss9AV7RgZc8DZEf02IPVUdtmjZFU8J4haWlzLMpbDHn7k1DWOzDBhouGXxjdzkf7a9
         hW4jKaT65kYXsKXnZozNNp9wv5e1XarvX2393vLqhhqPOShSR2qvyqKZKsidYedHip
         1OPyibdBW8RvqvyVrk0eEwTVsCIrbvpAe8KA95m/CXviLt0NvN++s6bscAsT/VUifo
         GnFUMC4z1IXpw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 92EE2C53BCD; Tue, 17 Oct 2023 10:52:23 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date:   Tue, 17 Oct 2023 10:52:23 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: glandvador@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-0jl9wSECKP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #16 from Eduard Kohler (glandvador@yahoo.com) ---
Oups not the right kernel version.
The 6.4.16 one is the one that it is working. The one with the issue (and
actually all of the 6.5 I tested) is:
Linux version 6.5.4-100.fc37.x86_64
(mockbuild@bkernel01.iad2.fedoraproject.org) (gcc (GCC) 12.3.1 20230508 (Red
Hat 12.3.1-1), GNU ld version 2.38-27.fc37) #1 SMP PREEMPT_DYNAMIC Tue Sep =
19
13:13:25 UTC 2023

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
