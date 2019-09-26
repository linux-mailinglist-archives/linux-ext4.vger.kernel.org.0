Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46CA2BE9E7
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2019 03:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfIZBKF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Sep 2019 21:10:05 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33241 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfIZBKE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Sep 2019 21:10:04 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iDIIA-0005Bo-Ez; Wed, 25 Sep 2019 19:09:58 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iDII8-0000OW-DU; Wed, 25 Sep 2019 19:09:58 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Theodore Tso <tytso@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
References: <cover.1568990048.git.luto@kernel.org>
        <66b16acf2953fc033abc9641b9cf43d23e75a8e9.1568990048.git.luto@kernel.org>
        <CAG48ez2tnJzLNCgAqCC+AOKuLGBSvBRi2_HZ97bEJ0zP1kWLHg@mail.gmail.com>
Date:   Wed, 25 Sep 2019 20:09:26 -0500
In-Reply-To: <CAG48ez2tnJzLNCgAqCC+AOKuLGBSvBRi2_HZ97bEJ0zP1kWLHg@mail.gmail.com>
        (Jann Horn's message of "Tue, 24 Sep 2019 22:30:55 +0200")
Message-ID: <87sgoj2795.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iDII8-0000OW-DU;;;mid=<87sgoj2795.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/1fUlC8WTamoL7df9TU6CVtkUKkHX1bNM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4943]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jann Horn <jannh@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1620 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 4.6 (0.3%), b_tie_ro: 3.2 (0.2%), parse: 1.22
        (0.1%), extract_message_metadata: 3.3 (0.2%), get_uri_detail_list:
        1.17 (0.1%), tests_pri_-1000: 4.4 (0.3%), tests_pri_-950: 1.55 (0.1%),
        tests_pri_-900: 1.28 (0.1%), tests_pri_-90: 24 (1.5%), check_bayes: 22
        (1.4%), b_tokenize: 6 (0.4%), b_tok_get_all: 7 (0.4%), b_comp_prob:
        2.2 (0.1%), b_tok_touch_all: 4.0 (0.2%), b_finish: 1.04 (0.1%),
        tests_pri_0: 1557 (96.1%), check_dkim_signature: 0.52 (0.0%),
        check_dkim_adsp: 3.2 (0.2%), poll_dns_idle: 1.17 (0.1%), tests_pri_10:
        4.2 (0.3%), tests_pri_500: 10 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 7/7] random: Remove kernel.random.read_wakeup_threshold
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Jann Horn <jannh@google.com> writes:

> On Fri, Sep 20, 2019 at 4:37 PM Andy Lutomirski <luto@kernel.org> wrote:
>> It has no effect any more, so remove it.  We can revert this if
>> there is some user code that expects to be able to set this sysctl.
>>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> ---
>>  drivers/char/random.c | 18 +-----------------
>>  1 file changed, 1 insertion(+), 17 deletions(-)
>>
>> diff --git a/drivers/char/random.c b/drivers/char/random.c
> [...]
>> -       {
>> -               .procname       = "read_wakeup_threshold",
>
> There's a line in bin_random_table in kernel/sysctl_binary.c that
> refers to this sysctl, that should probably also be deleted?

I think it should be safe to leave in kernel/sysctl_binary.c

This reminds me.  I think we may finally be at a point where we can
remove practically all of kernel/sysctl_binary.c

I need to double check but last I looked no distro enables
COINFIG_SYSCTL_SYSCALL anymore.  Ubunutu was the last distro I know of
that enabled it, and I think it has been a year or more since Ubuntu
disabled CONFIG_SYSCTL_SYSCALL.

Eric

