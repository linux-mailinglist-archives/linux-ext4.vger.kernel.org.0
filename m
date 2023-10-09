Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94DF7BE35C
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Oct 2023 16:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjJIOpw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Oct 2023 10:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjJIOpv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Oct 2023 10:45:51 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376BAB4
        for <linux-ext4@vger.kernel.org>; Mon,  9 Oct 2023 07:45:50 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c12ae20a5cso52407891fa.2
        for <linux-ext4@vger.kernel.org>; Mon, 09 Oct 2023 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696862748; x=1697467548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZgrGHyhh24SlGacSkXVqyUBpWvWe6J5YeMe4c0ejHI=;
        b=YC7Hw6NHS/83/jDb1jFWz7Akqjm+CBmaGIozGIRfXltiGI+gKqpd4jv3tpConA7Cx5
         6pAU/ThbnVIgOSFAcigjDv1LlVKBlbjdhVMOa32xRthBnrnNYmxABuii9aczcmLUXw4C
         wBM17Lv+WLbtLuiIJGkt4eoqyZ+FMDfnRy57bhpjYvGLXs0KAkZZf0VOa6yUv52w0nnU
         YXIjXntYfWoIDio6hdwbDic/ooJDi3Ng7evR9DRNyfgERA9SZI8TUehZ75621Zd8U+m1
         hiu6MqD93PmgwhLPfPLiIn3Oexxs0k9PlyG5T8bIERbLPGKPqsO3w5Zsucy9I0SVt7VB
         oemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696862748; x=1697467548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZgrGHyhh24SlGacSkXVqyUBpWvWe6J5YeMe4c0ejHI=;
        b=h+iJPW2RRa6WHKH5SPmJBTCkzUxR3rN8xAEW6aloWvMY7Nx1cExbrmKi3D9ZdPvG3p
         vIBMTnG6vRJRChpovrndOfM7eFLVL2gX85aWXoZo7UOQgKkNZ0Gz5Lo+QsJSUtPQR7ZY
         6e2DNYoPlIWU+egkfG9tmMppM53VD37lg7QBzrmujjOAO1XZWpk4ZTXjJmwN1i02PW6i
         qsFHUq76ekdz/CcRUuJnnvw8yn6Jf3CN78oruPYRaZG3OgOgLLvrXm9htA6Y+fXKyvqK
         C4DHjpKPq7AsCmaOX/d1JY+qxzeSl3re90xlquSfGe7ZEbxDVi/koN4Jg8z8BPFExVJW
         8qcw==
X-Gm-Message-State: AOJu0Yyzk8zxzl3kb1XN3/i6m8S2098wBT7yZGVOI7KJgyuOwh+T60IZ
        CP9FCmrQ8E1iU6EJOVEESa0tjhpfqJkVW+1Ow7jKlQ==
X-Google-Smtp-Source: AGHT+IEDF91AvHzJpEgtXdwIiAxumKeC+rEr/GbEpvbUT0VJVZba6pc2wxKxrHSdG/c5v7SZWrawJk6SFkdCVO2SYiE=
X-Received: by 2002:a2e:7204:0:b0:2c0:21b6:e80c with SMTP id
 n4-20020a2e7204000000b002c021b6e80cmr13617400ljc.35.1696862748450; Mon, 09
 Oct 2023 07:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230919081900.1096840-1-max.kellermann@ionos.com> <69dda7be-d7c8-401f-89f3-7a5ca5550e2f@oracle.com>
In-Reply-To: <69dda7be-d7c8-401f-89f3-7a5ca5550e2f@oracle.com>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Mon, 9 Oct 2023 16:45:37 +0200
Message-ID: <CAKPOu+9aeEXf=HdVMeG-o17NeDZd8=+LGxD4QYER2ibUPbH6kw@mail.gmail.com>
Subject: Re: [PATCH] fs: apply umask if POSIX ACL support is disabled
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 3, 2023 at 5:32=E2=80=AFPM Dave Kleikamp <dave.kleikamp@oracle.=
com> wrote:
> I think this is sane, but the patch needs a description of why this is
> necessary for these specific file systems.

Indeed the patch description was lacking, sorry. I sent v2 with a
better description.

Max
