Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9906A59E7A1
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Aug 2022 18:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245203AbiHWQi6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Aug 2022 12:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245014AbiHWQiE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Aug 2022 12:38:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EBD4D4C2;
        Tue, 23 Aug 2022 06:07:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A1624336D1;
        Tue, 23 Aug 2022 13:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661260053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O/ii+lOdNn7YfB+uRvuBLwUv3aBhJOTFT/L0utGIEpo=;
        b=uQz41YgXjoWruZybjpnEznVOMrI0Ta0Z5cuCPIqd4Rpvi+LHKLpR9TsGiGrjHiWLhJprzw
        H+KUnvYQIopBU+BQLGThfwhX2lhDNq12IqCoHaS1cEc1yh6pI02mt3S3qHu9Qop/p0E0fk
        PLiH2v4Zlgkm2KI4Z+ZgbC2l92YmzE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661260053;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O/ii+lOdNn7YfB+uRvuBLwUv3aBhJOTFT/L0utGIEpo=;
        b=1xGvO2ZshrwMN6wB3/EAXA+Whmx/UjdkUO78nRCvJ+Zn7xf6dELC2Tej+TT4Rg5PuRrHv2
        SpWbS5BCRW2aQEDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 918EC13A89;
        Tue, 23 Aug 2022 13:07:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xqR6IxXRBGMLWgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 23 Aug 2022 13:07:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 074ACA067B; Tue, 23 Aug 2022 15:07:33 +0200 (CEST)
Date:   Tue, 23 Aug 2022 15:07:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     yebin <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] jbd2: detect old record when do journal scan
Message-ID: <20220823130732.73ifn3qwvnj7xh4b@quack3>
References: <20220810013442.3474533-1-yebin10@huawei.com>
 <20220819095445.yq4d2qhrhb73p3zk@quack3>
 <63049B47.2000408@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63049B47.2000408@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 23-08-22 17:17:59, yebin wrote:
> On 2022/8/19 17:54, Jan Kara wrote:
> > On Wed 10-08-22 09:34:42, Ye Bin wrote:
> > > As https://github.com/tytso/e2fsprogs/issues/120 describe tune2fs do not update
> > > j_tail_sequence when do journal recovery. This maybe recover old journal record,
> > > then will lead to file system corruption.
> > > To avoid file system corruption in this case, if detect current transaction's
> > > commit time earlier than previous transaction's commit time when do journal
> > > scan, just return error.
> > > 
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > Thanks for the patch! Let me see if I understand your concern right. You
> > are concerned about the following scenario:
> > 
> > 1) Kernel uses the filesystem, there's a crash.
> > 2) E2fsprogs replays the journal but fails to update sb->s_sequence in the
> > journal superblock.
> > 3) Kernel mounts the fs again - however note that even if kernel skips
> > recovery, it does scan the journal jbd2_journal_skip_recovery() and
> > journal->j_transaction_sequence is set based on the last transaction found
> > in the journal.
> > 
> > So I don't think there is really possibility we will quickly reuse some
> > transaction IDs and thus possibility of corruption on replay? Am I missing
> > something?
> > 
> The file system corruption I encountered was indeed because e2fsprogs did
> not update
> journal - > J_ transaction_ Sequence leads to replay the old transaction.
> So I wonder whether the kernel should detect this kind of exception, at
> least when there
> is a file system corruption, there are clues to trace.

OK, but what is not quite clear to me is why the kernel started to replay
the journal in the first place. Didn't e2fsprogs mark the filesystem as
clean after replaying the journal for some reason?

I'm asking because checking transaction validity based on wall clock time
has its own issues as well (clock gets skewed, updated via ntpd, BIOS can
reset it to some random value etc.) so adding the check you propose can
also create new issues...

								Honza

> > > diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> > > index f548479615c6..f3def21a96a5 100644
> > > --- a/fs/jbd2/recovery.c
> > > +++ b/fs/jbd2/recovery.c
> > > @@ -812,8 +812,17 @@ static int do_one_pass(journal_t *journal,
> > >   					break;
> > >   				}
> > >   			}
> > > -			if (pass == PASS_SCAN)
> > > +			if (pass == PASS_SCAN) {
> > > +				if (commit_time < last_trans_commit_time) {
> > > +					pr_err("JBD2: old journal record found "
> > > +					       "in transaction %u\n",
> > > +					       next_commit_ID);
> > > +					err = -EFSBADCRC;
> > > +					brelse(bh);
> > > +					goto failed;
> > > +				}
> > >   				last_trans_commit_time = commit_time;
> > > +			}
> > >   			brelse(bh);
> > >   			next_commit_ID++;
> > >   			continue;
> > > -- 
> > > 2.31.1
> > > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
