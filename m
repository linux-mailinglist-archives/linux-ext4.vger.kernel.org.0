Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421E743948D
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Oct 2021 13:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhJYLO6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Oct 2021 07:14:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230232AbhJYLO5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 25 Oct 2021 07:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635160355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vnbzxjZbHVjgrTYdokrc0WiK6M6NmcDLgA4GDSVOsCU=;
        b=Odn2K2AiJgHG2tRR/CPRJAIj/WLz+Hgt0jld2Z+1LTDxg/KESjRNsv3OvdZOthG5FhtqcU
        C2yZrVhew9OJVbp3RGrVCJ+R+EUcer9ENmJ7zqaEuVmHYbMWXArw4pZ5cGWZTC8r47EhoJ
        jcX1GtEM03LXa/lF+K9noo5rjgaXjx8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-0bmSvUK2Neyu-abpgQwzUA-1; Mon, 25 Oct 2021 07:12:34 -0400
X-MC-Unique: 0bmSvUK2Neyu-abpgQwzUA-1
Received: by mail-wm1-f70.google.com with SMTP id c5-20020a05600c0ac500b0030dba7cafc9so3514770wmr.5
        for <linux-ext4@vger.kernel.org>; Mon, 25 Oct 2021 04:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=vnbzxjZbHVjgrTYdokrc0WiK6M6NmcDLgA4GDSVOsCU=;
        b=VCamAMCQG2rxfiwLkZ22Sn23k4XhqbAHF38bPYnBhsUVct9z9Af49qe9+NYz/4Idp+
         YYL1ym3+Mqc12+fh70n4iCqfS8bQykphLQ4jk1oUQbT0laqygjr056+Vc8oLOasB1ALG
         bmxhLpY03N2XNLqFs7Zrh+bL4AdS8kTN7u3dH7l6xrLKITlmTrygZux21KPcM9DokzZ7
         /SdcIAv01J5rOiEP24kCeX53GvX4fHZ1LNVpvDtK+yAqBd9yNqyXamY6OziBvnzlUk/F
         CIixjET+VXtNi7+CFbOUI/VvN71c9xfku1esE0BFRf1DTry3iou22eVezE46+wX8NYfH
         kGGg==
X-Gm-Message-State: AOAM532MXVrFUHdeY+++GtpfySOJxeGv8W2hHjgSIpriDilcfd3ZYdtK
        F7b+J5Bms6SO3KpwsW8VBsWgG2ZZ57Q/H5ATaWnaVv9OTZ7e0kc1A5BjwJH7xKOtSAuR7AeZ/zO
        wyGmZY/COYzAsysJ2C1jiog==
X-Received: by 2002:a05:600c:3393:: with SMTP id o19mr49404648wmp.66.1635160352920;
        Mon, 25 Oct 2021 04:12:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMdO6lF0IB2SndxFlrRFBxLuV5+EhlabE63dVX6Dw6ZRWMLdNgP1jbUsplCPNyPYtMn7J5RQ==
X-Received: by 2002:a05:600c:3393:: with SMTP id o19mr49404621wmp.66.1635160352647;
        Mon, 25 Oct 2021 04:12:32 -0700 (PDT)
Received: from andromeda.lan (ip4-46-39-172-19.cust.nbox.cz. [46.39.172.19])
        by smtp.gmail.com with ESMTPSA id l5sm16293511wru.24.2021.10.25.04.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 04:12:32 -0700 (PDT)
Date:   Mon, 25 Oct 2021 13:12:29 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 01/13] fs_parse: allow parameter value to be empty
Message-ID: <20211025111229.zvk6np675v5fip2j@andromeda.lan>
Mail-Followup-To: Lukas Czerner <lczerner@redhat.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
References: <20211021114508.21407-1-lczerner@redhat.com>
 <20211021114508.21407-2-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021114508.21407-2-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 21, 2021 at 01:44:56PM +0200, Lukas Czerner wrote:
> Allow parameter value to be empty by spcifying fs_param_can_be_empty
					^ specifying


Other than that, the patch looks fine:

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>


> +	if (!*param->string && (p->flags & fs_param_can_be_empty))

> +		return 0;
>  	b = lookup_constant(bool_names, param->string, -1);
>  	if (b == -1)
>  		return fs_param_bad_value(log, param);
> @@ -211,8 +213,11 @@ int fs_param_is_u32(struct p_log *log, const struct fs_parameter_spec *p,
>  		    struct fs_parameter *param, struct fs_parse_result *result)
>  {
>  	int base = (unsigned long)p->data;
> -	if (param->type != fs_value_is_string ||
> -	    kstrtouint(param->string, base, &result->uint_32) < 0)
> +	if (param->type != fs_value_is_string)
> +		return fs_param_bad_value(log, param);
> +	if (!*param->string && (p->flags & fs_param_can_be_empty))
> +		return 0;
> +	if (kstrtouint(param->string, base, &result->uint_32) < 0)
>  		return fs_param_bad_value(log, param);
>  	return 0;
>  }
> @@ -221,8 +226,11 @@ EXPORT_SYMBOL(fs_param_is_u32);
>  int fs_param_is_s32(struct p_log *log, const struct fs_parameter_spec *p,
>  		    struct fs_parameter *param, struct fs_parse_result *result)
>  {
> -	if (param->type != fs_value_is_string ||
> -	    kstrtoint(param->string, 0, &result->int_32) < 0)
> +	if (param->type != fs_value_is_string)
> +		return fs_param_bad_value(log, param);
> +	if (!*param->string && (p->flags & fs_param_can_be_empty))
> +		return 0;
> +	if (kstrtoint(param->string, 0, &result->int_32) < 0)
>  		return fs_param_bad_value(log, param);
>  	return 0;
>  }
> @@ -231,8 +239,11 @@ EXPORT_SYMBOL(fs_param_is_s32);
>  int fs_param_is_u64(struct p_log *log, const struct fs_parameter_spec *p,
>  		    struct fs_parameter *param, struct fs_parse_result *result)
>  {
> -	if (param->type != fs_value_is_string ||
> -	    kstrtoull(param->string, 0, &result->uint_64) < 0)
> +	if (param->type != fs_value_is_string)
> +		return fs_param_bad_value(log, param);
> +	if (!*param->string && (p->flags & fs_param_can_be_empty))
> +		return 0;
> +	if (kstrtoull(param->string, 0, &result->uint_64) < 0)
>  		return fs_param_bad_value(log, param);
>  	return 0;
>  }
> @@ -244,6 +255,8 @@ int fs_param_is_enum(struct p_log *log, const struct fs_parameter_spec *p,
>  	const struct constant_table *c;
>  	if (param->type != fs_value_is_string)
>  		return fs_param_bad_value(log, param);
> +	if (!*param->string && (p->flags & fs_param_can_be_empty))
> +		return 0;
>  	c = __lookup_constant(p->data, param->string);
>  	if (!c)
>  		return fs_param_bad_value(log, param);
> @@ -255,7 +268,8 @@ EXPORT_SYMBOL(fs_param_is_enum);
>  int fs_param_is_string(struct p_log *log, const struct fs_parameter_spec *p,
>  		       struct fs_parameter *param, struct fs_parse_result *result)
>  {
> -	if (param->type != fs_value_is_string || !*param->string)
> +	if (param->type != fs_value_is_string ||
> +	    (!*param->string && !(p->flags & fs_param_can_be_empty)))
>  		return fs_param_bad_value(log, param);
>  	return 0;
>  }
> @@ -275,7 +289,8 @@ int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
>  {
>  	switch (param->type) {
>  	case fs_value_is_string:
> -		if (kstrtouint(param->string, 0, &result->uint_32) < 0)
> +		if ((!*param->string && !(p->flags & fs_param_can_be_empty)) ||
> +		    kstrtouint(param->string, 0, &result->uint_32) < 0)
>  			break;
>  		if (result->uint_32 <= INT_MAX)
>  			return 0;
> diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
> index aab0ffc6bac6..f103c91139d4 100644
> --- a/include/linux/fs_parser.h
> +++ b/include/linux/fs_parser.h
> @@ -42,7 +42,7 @@ struct fs_parameter_spec {
>  	u8			opt;	/* Option number (returned by fs_parse()) */
>  	unsigned short		flags;
>  #define fs_param_neg_with_no	0x0002	/* "noxxx" is negative param */
> -#define fs_param_neg_with_empty	0x0004	/* "xxx=" is negative param */
> +#define fs_param_can_be_empty	0x0004	/* "xxx=" is allowed */
>  #define fs_param_deprecated	0x0008	/* The param is deprecated */
>  	const void		*data;
>  };
> -- 
> 2.31.1
> 

-- 
Carlos

