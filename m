Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F693031FF
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Jan 2021 03:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbhAYP5L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Jan 2021 10:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbhAYPyd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Jan 2021 10:54:33 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682A1C0613D6;
        Mon, 25 Jan 2021 07:53:46 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id s15so7840650plr.9;
        Mon, 25 Jan 2021 07:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=soQv/oWN+cjpfz5dkFYcYLTA8n5I/JCS6Ll0z44P+AY=;
        b=lc9p7Tb8EIl/bTbFEWJ38/Vb0W1iCCfMwApHwja51EcV+j/yoA19HM/rUIXN9HhMRp
         n08RYACUu02iJgdeqQqcY28H5A7kdKqKnC8WhZHU+aMNTzS4VFXFXlHnWJKfrVFfakOa
         5XmmTMLD31c5lpONE2MlQMcR2z5Hef/1FEg2bIEVDdj2+KJHOAVgCeiZwoFhwLBKBoqe
         NwedY/RmRvwOnvNjugyC8N8rRa812OWhdKF7K11HOUbGahURRh8qIOgm+6qdTY23bgp+
         dOBQN6YLzNvmof52hcJDcdsl73XpSruOwgjCDqn0+zYSxEA0mR0TLgN26rzjL6Mt+ebW
         0saA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=soQv/oWN+cjpfz5dkFYcYLTA8n5I/JCS6Ll0z44P+AY=;
        b=jcvGqEG2ohaRiRbZGn+l9hSydgv1SHH9eYBFtbjRKVzfR0RA16Zalb6SthFD5QIHuO
         T2AIzz6A8doSkNW8OR6TZejuOY957MOup6AJG6/LYuag8cmAu5GwZLVWTyQgyl4jHVFy
         GeltkMWGIFL8pBfhoyb2jYl5ybJ190+CEfnzqWF/n6PgilvCZ0SopJPWnfEEKU62NDUt
         cI3Yw6Ivx3KxKqVrXtI4VPhkd0hs/6JAApi19Z8+DHduWMUbCLwX0xuMA5ToJoLXYSB6
         uobtIvsD6z6+h4PQHfvvgxzLQqcBtnO3udFExfSWbhDb7AOTOLhabYvQ80wxzyU3M9U1
         dWyA==
X-Gm-Message-State: AOAM530dnfpfU+TfoPjxbz8izLokoMmsEQQTSUc/osP4DSZVCXRT7gqm
        GNotbsTo3vOg1FCQM5oWNq2r9DkLY1z5mQ4E
X-Google-Smtp-Source: ABdhPJytrmJs5TcORY1Dgr3sO8h/TLy+IXV7HdrKWlztG6OTHCiGJVPnqjtUtGH98AVeOr9LQdzeSA==
X-Received: by 2002:a17:90a:e547:: with SMTP id ei7mr898226pjb.34.1611590025578;
        Mon, 25 Jan 2021 07:53:45 -0800 (PST)
Received: from [127.0.0.1] ([203.205.141.48])
        by smtp.gmail.com with ESMTPSA id 16sm19461373pjc.28.2021.01.25.07.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 07:53:45 -0800 (PST)
Subject: Re: [RFC PATCH v2 2/4] jbd2: introduce some new log interfaces
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
        harshadshirwadkar@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1611402263.git.brookxu@tencent.com>
 <f19b925451351040a7e831bb1c96f062421c8ce8.1611402263.git.brookxu@tencent.com>
 <20210125145448.GG1175@quack2.suse.cz>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <81586eb0-921c-9fd2-96ef-2fa249ef3b85@gmail.com>
Date:   Mon, 25 Jan 2021 23:53:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125145448.GG1175@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Jan Kara wrote on 2021/1/25 22:54:
> On Sat 23-01-21 20:00:44, Chunguang Xu wrote:
>> From: Chunguang Xu <brookxu@tencent.com>
>>
>> Compared to directly using numbers to indicate levels, using abstract
>> error, warn, notice, info, debug to indicate levels may be more
>> convenient for code reading and writing. Similar to other kernel
>> modules, some basic log interfaces are introduced.
>>
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> 
> One more thing I've noticed when reading this patch:
> 
>> +
>> +#ifdef CONFIG_JBD2_DEBUG
>> +/*
>> + * Define JBD2_EXPENSIVE_CHECKING to enable more expensive internal
>> + * consistency checks.  By default we don't do this unless
>> + * CONFIG_JBD2_DEBUG is on.
>> + */
>> +#define JBD2_EXPENSIVE_CHECKING
>> +extern ushort jbd2_journal_enable_debug;
>> +void jbd2_log(int level, journal_t *j, const char *file, const char *func,
>> +		      unsigned int line, const char *fmt, ...);
>> +
>> +#define JBD2_ERR	1	/* error conditions */
>> +#define JBD2_WARN	2	/* warning conditions */
>> +#define JBD2_NOTICE	3	/* normal but significant condition */
>> +#define JBD2_INFO	4	/* informational */
>> +#define JBD2_DEBUG	5	/* debug-level messages */
> 
> This is actually not true. All the jbd_debug() messages are really debug
> messages, not errors, not warnings. It is just a different level of detail.
> Honestly, these days, I'd rather discard all the levels, use pr_debug()
> function to print these messages inside jdb2_debug() and defer to
> CONFIG_DYNAMIC_DEBUG framework for configuration of which messages are
> interesting for a particular debug session.

From a certain point, this is indeed, maybe the changes here are not necessary.
Thanks.

> 								Honza
> 
>> +
>> +#define jbd2_err(j, fmt, a...)						\
>> +	jbd2_log(JBD2_ERR, j, __FILE__, __func__, __LINE__, (fmt), ##a)
>> +
>> +#define jbd2_warn(j, fmt, a...)						\
>> +	jbd2_log(JBD2_WARN, j, __FILE__, __func__, __LINE__, (fmt), ##a)
>> +
>> +#define jbd2_notice(j, fmt, a...)					\
>> +	jbd2_log(JBD2_NOTICE, j, __FILE__, __func__, __LINE__, (fmt), ##a)
>> +
>> +#define jbd2_info(j, fmt, a...)						\
>> +	jbd2_log(JBD2_INFO, j, __FILE__, __func__, __LINE__, (fmt), ##a)
>> +
>> +#define jbd2_debug(j, fmt, a...)					\
>> +	jbd2_log(JBD2_DEBUG, j, __FILE__, __func__, __LINE__, (fmt), ##a)
>> +
>> +#else
>> +
>> +#define jbd2_err(j, fmt, a...)
>> +#define jbd2_warn(j, fmt, a...)
>> +#define jbd2_notice(j, fmt, a...)
>> +#define jbd2_info(j, fmt, a...)
>> +#define jbd2_debug(j, fmt, a...)
>> +
>> +#endif
>>  #endif
>>  
>>  /*
>> -- 
>> 2.30.0
>>
