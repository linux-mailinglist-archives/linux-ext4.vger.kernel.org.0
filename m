Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907EE4D5961
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Mar 2022 05:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbiCKEDu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Mar 2022 23:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242746AbiCKEDt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Mar 2022 23:03:49 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F28BECC8
        for <linux-ext4@vger.kernel.org>; Thu, 10 Mar 2022 20:02:47 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a8so16515946ejc.8
        for <linux-ext4@vger.kernel.org>; Thu, 10 Mar 2022 20:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ce5ASUN/YpMffyWs3RqKg3VfO3dF6LZerAfpmFkK37A=;
        b=Hm6Y4XMc9K20F4QPUdP6PnfK3/ksAeIb07FGor8NdTBa/VPSrmq/ZkJ2MJyLugc0rr
         RwB6vlk0zRHzYh94DaCbwTqeQrFYa9hI09oLeuQrCb9yaaTOCcSHTsL9H8WhDbgpWCAr
         66syo3nJTD6uuZUbNlYIlr+7hnxrtwXMCDLyGhNMNvKzPqOSXNeXtlU1w181ovtr8Mv6
         ZpUR54EwM9xaVXbXuQTxtfc8MvfN4xw600YpnyrjzpCLN8e+dJUE5utgmt9drRzOQPBO
         lyEWKy7uy9M8ZJei06/N3U/9gHujTLFYw+ut+tWx0pZMsI48FqCN4dOXkGa9+d7hC/aX
         fxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ce5ASUN/YpMffyWs3RqKg3VfO3dF6LZerAfpmFkK37A=;
        b=VWkxFjTwGMRudLG+UzkB3TTLGwRfvtKkmbn7+dVukM1/m/NpVjuuEFJfAwKFfz++Wy
         iwu+lF6oVxDegYdgLTzkGyUfJXwp+FYb3gFYyN78Ry/Ey+rW1aTrYHLxD3WRUxrg1dkw
         1XuMsXfCSuq3uLfbNruhVyMC5bTtYtWeQGts09KSMcmiJEiozZa3yc/Oe0NBhQVC92i5
         +TvC1Nw8EvJvkUKw921bMXJK6E0NW75hvZGwZZGPUg6NkxlVaIaOAVUiYqPWeaPwGGyt
         Cg9TChzQS7xLUWov1EZq0/TacJwb0fEdiLB0HJylOY4bIAKnERxKhYQvLqsxEf024ec9
         jwmA==
X-Gm-Message-State: AOAM531u3FrYuDkKbfTqQBGtAha4wiIRYyJHLU3hODiqICYhvsTsciDB
        wp2L8sOrGYb5krGWXhzfO8QWVpl93lSq0XGp2dI=
X-Google-Smtp-Source: ABdhPJzJB/bpV1b2KA4GdkoQHna6vSLYWzw4nXQ4Syg2/77p+vtO1VNyUxB0sMbSigcdflA7HgBLzHNFzhAyHHr1spg=
X-Received: by 2002:a17:906:1e42:b0:6d6:df12:7f8d with SMTP id
 i2-20020a1709061e4200b006d6df127f8dmr7126661ejj.15.1646971365185; Thu, 10 Mar
 2022 20:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20220308163319.1183625-1-harshads@google.com> <20220308163319.1183625-2-harshads@google.com>
 <20220309101057.3uuix2gvjinobt3i@quack3.lan>
In-Reply-To: <20220309101057.3uuix2gvjinobt3i@quack3.lan>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 10 Mar 2022 20:02:33 -0800
Message-ID: <CAD+ocbyCVc9EL-HdrNHgnHqGS1ymhC6U7eQXuQeJW228WvrHyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] ext4: convert i_fc_lock to spinlock
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 9 Mar 2022 at 02:10, Jan Kara <jack@suse.cz> wrote:
>
> On Tue 08-03-22 08:33:15, Harshad Shirwadkar wrote:
> > From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> >
> > Convert ext4_inode_info->i_fc_lock to spinlock to avoid sleeping
> > in invalid contexts.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> One comment below...
>
> > @@ -972,9 +970,13 @@ static int ext4_fc_wait_inode_data_all(journal_t *journal)
> >
> >       spin_lock(&sbi->s_fc_lock);
> >       list_for_each_entry_safe(pos, n, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> > +             spin_lock(&pos->i_fc_lock);
> >               if (!ext4_test_inode_state(&pos->vfs_inode,
> > -                                        EXT4_STATE_FC_COMMITTING))
> > +                                        EXT4_STATE_FC_COMMITTING)) {
> > +                     spin_unlock(&pos->i_fc_lock);
> >                       continue;
> > +             }
> > +             spin_unlock(&pos->i_fc_lock);
> >               spin_unlock(&sbi->s_fc_lock);
>
> Why do you add a lock here in a pure lock-conversion patch? Furthermore I
> don't think the lock is needed...
Oops sorry, this was an unintentional leftover from the first version,
I'll remove it in the next one, thanks!

- Harshad
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
