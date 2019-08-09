Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1738188487
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 23:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfHIVUW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Aug 2019 17:20:22 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39479 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfHIVUW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Aug 2019 17:20:22 -0400
Received: by mail-ot1-f66.google.com with SMTP id r21so131965471otq.6
        for <linux-ext4@vger.kernel.org>; Fri, 09 Aug 2019 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pCxfpYfrohJOa/YQNK7w4lvqmXX/vmz1SK0u4S/kd18=;
        b=T9uIddpw3msyHWGu627JvjR4zZZUgHzJ3u8pW06kGpAQU7g/5ZH8+aQGbKP0nWQdM3
         4sPkJwYhieAEHOyzgLeTkUifoKon3YY+0jbm5HYHGL+h9y2F3tKZPwm+bqtprq4Vo0PF
         BG0SKnLbw0UnIpkndrm4dx9oPvb351spsF3VmDTwnejJZanbeWvMzAV8a0b4nbKOX+fo
         CeiOpjUBsSk1VB3G/Nd7pb+kjhP90FwCEyVOXPOBdGxqohbf+WuaQCzF+6hGzvaCnCk5
         +F4UFG12AlcVbNfawRWePbFmngemekhEWq7tBEuRnDEkKmRVY0Wj+NT7fpiwZ74gzFYe
         CFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pCxfpYfrohJOa/YQNK7w4lvqmXX/vmz1SK0u4S/kd18=;
        b=DYhR42Zd9RgshWpvfhU9Gy68QsW3heJFirValzbaEDPjaywPksXXNtKV2XUPA6lj5U
         j7rMrKZoDRpx2gplkDq4y/zdJE/JRnjS61kmzoueaOw9ju8SvWYISBzpuHk6VuGLinM+
         5D3vSEHx19Sb654noHYSOhoJcuFImYKI7zSRwjojkHbOlvkQL+CUbuEWvd1g8GYuqdDZ
         oaNzr8TrQwJ+9DMdHnNQNTouRMJItRn3pby7CklXDyWlNxdytp5B1IHnNt/4QTdECF08
         KsQYt8jTx/1FoqzKwBWjwUUUBRHG42c8/uN2q2AFMYq7D+QUtAdwBWRdhgtxE88/2wMs
         J6XQ==
X-Gm-Message-State: APjAAAXyxuGywkarCNFtGyvbK9v7HtyhXAmFckrqMy+QhrkFkPquXl8q
        POtsd54lWGVAGT+bNfubkIukPtNXpV/F8S4CotGDNEzu
X-Google-Smtp-Source: APXvYqwTEDHwqLut4l7q004iaMRjxCgiIbDTXk69Shf1SUUV4kVmFvHxlExPqiLlam3httQYGhh2KRWH3gM6pGZqg3k=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr20452744otk.363.1565385620624;
 Fri, 09 Aug 2019 14:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
 <20190809034552.148629-6-harshadshirwadkar@gmail.com> <6DBCC366-02CC-4F2A-AA16-EC4587261699@dilger.ca>
 <D5F6A0C1-D139-4BF9-B8C4-FE673D9CEBA4@dilger.ca>
In-Reply-To: <D5F6A0C1-D139-4BF9-B8C4-FE673D9CEBA4@dilger.ca>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 9 Aug 2019 14:20:09 -0700
Message-ID: <CAD+ocbw-n16s0nZvxLR=HrkWBvs1tzY3-rtqnbwfUz74DuaRJg@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] jbd2: fast-commit commit path new APIs
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 9, 2019 at 2:11 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
>
> > On Aug 9, 2019, at 2:38 PM, Andreas Dilger <adilger@dilger.ca> wrote:
> >
> > On Aug 8, 2019, at 9:45 PM, Harshad Shirwadkar <harshadshirwadkar@gmail.com> wrote:
> >>
> >> This patch adds new helper APIs that ext4 needs for fast
> >> commits. These new fast commit APIs are used by subsequent fast commit
> >> patches to implement fast commits. Following new APIs are added:
> >>
> >> /*
> >> * Returns when either a full commit or a fast commit
> >> * completes
> >> */
> >> int jbd2_fc_complete_commit(journal_tc *journal, tid_t tid,
> >>                          tid_t tid, tid_t subtid)
> >>
> >> /* Send all the data buffers related to an inode */
> >> int journal_submit_inode_data(journal_t *journal,
> >>                            struct jbd2_inode *jinode)
> >>
> >> /* Map one fast commit buffer for use by the file system */
> >> int jbd2_map_fc_buf(journal_t *journal, struct buffer_head **bh_out)
> >>
> >> /* Wait on fast commit buffers to complete IO */
> >> jbd2_wait_on_fc_bufs(journal_t *journal, int num_bufs)
> >>
> >> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> >>
> >> +int jbd2_map_fc_buf(journal_t *journal, struct buffer_head **bh_out)
> >> +{
> >> +    unsigned long long pblock;
> >> +    unsigned long blocknr;
> >> +    int ret = 0;
> >> +    struct buffer_head *bh;
> >> +    int fc_off;
> >> +    journal_header_t *jhdr;
> >> +
> >> +    write_lock(&journal->j_state_lock);
> >> +
> >> +    if (journal->j_fc_off + journal->j_first_fc < journal->j_last_fc) {
> >> +            fc_off = journal->j_fc_off;
> >> +            blocknr = journal->j_first_fc + fc_off;
> >> +            journal->j_fc_off++;
> >> +    } else {
> >> +            ret = -EINVAL;
> >> +    }
> >> +    write_unlock(&journal->j_state_lock);
> >> +
> >> +    if (ret)
> >> +            return ret;
> >> +
> >> +    ret = jbd2_journal_bmap(journal, blocknr, &pblock);
> >> +    if (ret)
> >> +            return ret;
> >> +
> >> +    bh = __getblk(journal->j_dev, pblock, journal->j_blocksize);
> >> +    if (!bh)
> >> +            return -ENOMEM;
> >> +
> >> +    lock_buffer(bh);
> >> +    jhdr = (journal_header_t *)bh->b_data;
> >> +    jhdr->h_magic = cpu_to_be32(JBD2_MAGIC_NUMBER);
> >> +    jhdr->h_blocktype = cpu_to_be32(JBD2_FC_BLOCK);
> >> +    jhdr->h_sequence = cpu_to_be32(journal->j_running_transaction->t_tid);
> >> +
> >> +    set_buffer_uptodate(bh);
> >> +    unlock_buffer(bh);
> >> +    journal->j_fc_wbuf[fc_off] = bh;
> >> +
> >> +    *bh_out = bh;
> >> +
> >> +    return 0;
> >> +}
> >> +EXPORT_SYMBOL(jbd2_map_fc_buf);
>
> One question about this function.  It seems that it is called for every
> commit by ext4_journal_fc_commit_cb().  Why does it need to map the fast
> journal commit blocks on every call?  It would make more sense to map the
> blocks once at initialization time and then just re-use them on each call.
>

The only reason why I did it this way is that this way JBD2 gets an
opportunity to set-up journal header at the beginning of the block
which contains TID information. But I guess we could have a separate
call for setting the journal header and ext4 could call that routine
instead of mapping buffers on every commit call. Thanks for pointing
this out. I'll fix this in V3.

> Cheers, Andreas
>
>
>
>
>
